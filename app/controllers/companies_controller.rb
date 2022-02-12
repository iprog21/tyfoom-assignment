class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: %i[provision auth_callback]
  before_action :authenticate_admin!, except: %i[provision auth_callback]
  before_action :set_company, only: %i[ show edit update destroy provision auth_callback]

  # GET /companies or /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1 or /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies or /companies.json
  def create
   
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save

        app = Doorkeeper::Application.create(name: "#{@company.name}-#{@company.id}", redirect_uri: auth_callback_company_url(@company), scopes: ["public"])
        @company.update_column(:application_id, app.id)

        format.html { redirect_to companies_path, notice: "Company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1 or /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to company_url(@company), notice: "Company was successfully updated." }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1 or /companies/1.json
  def destroy
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url, notice: "Company was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def provision
    user = User.find_by(id: params[:user_id])
    callback = auth_callback_company_url(@company)
    app_id = @company.application[:uid]
    secret = @company.application[:secret]
    client = OAuth2::Client.new(app_id, secret, site: root_url)
    authorize_url = client.auth_code.authorize_url(redirect_uri: callback)
    redirect_to authorize_url
  end

  def auth_callback
    callback = auth_callback_company_url(@company)
    # byebug
    app_id = @company.application[:uid]
    secret = @company.application[:secret]
    client = OAuth2::Client.new(app_id, secret, site: root_url)
    
    Spawnling.new do
      access = client.auth_code.get_token(params[:code], redirect_uri: callback)

      current_user.access_token = access.token
      current_user.company_id = @company.id
      current_user.save
    end
    redirect_to apis_url, notice: "Successfully provision to #{@company.name}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:name)
    end
end
