class HomeController < ApplicationController
  def index
    @sign_in_url = clerk.sign_in_url
    @sign_up_url = clerk.sign_up_url
  end
end
