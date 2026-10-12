class HomeController < ApplicationController
  def index
    @sign_in_url = clerk.sign_in_url
  end
end
