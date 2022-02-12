class AddApplicationIdToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :application_id, :integer
  end
end
