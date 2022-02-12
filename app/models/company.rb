class Company < ApplicationRecord
  has_many :users
  def application
    OauthApplication.find_by(id: self.application_id)
  end
end
