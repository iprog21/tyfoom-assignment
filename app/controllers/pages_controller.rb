class PagesController < ApplicationController
  def home
    @companies = Company.all
  end
  def apis
  end
end