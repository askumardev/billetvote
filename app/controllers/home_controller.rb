class HomeController < ApplicationController
  #before_action :authenticate_user!
  def index
    @sign_in_url = clerk.sign_in_url
  end
end
