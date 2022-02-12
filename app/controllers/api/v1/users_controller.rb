class Api::V1::UsersController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    render json: company.users
  end

  private

  def current_user
    @current_user ||= User.find_by(id: doorkeeper_token.resource_owner_id)
  end

  def company
    @company ||= current_user.company
  end
end