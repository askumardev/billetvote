class SessionsController < ApplicationController
  def new
    @sign_up_url = clerk.sign_up_url
  end
end
