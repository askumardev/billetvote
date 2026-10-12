class RegistrationsController < ApplicationController
  def new
    {}
  end

  def create
    attributes = registration_params

    if attributes[:password] != attributes[:password_confirmation]
      flash.now[:alert] = "Passwords do not match."
      render :new, status: :unprocessable_entity
      return
    end
    request = Clerk::Models::Operations::CreateUserRequest.new(
      first_name: attributes[:first_name],
      last_name: attributes[:last_name],
      email_address: [attributes[:email]],
      password: attributes[:password]
    )

    response = clerk_sdk.users.create(request: request)
    status = response.raw_response.status

    if status.between?(200, 299)
      redirect_to login_path,
                  notice: "Account created successfully. Please sign in."
    else
      Rails.logger.error(
        "Clerk registration failed with HTTP status #{status}"
      )

      flash.now[:alert] = "Registration failed. Please try again."
      render :new, status: :unprocessable_entity
    end
  rescue StandardError => e
    Rails.logger.error(
      "Clerk registration error: #{e.class}"
    )

    flash.now[:alert] = "Unable to register. Please try again."
    render :new, status: :unprocessable_entity

  end

  private

  def registration_params
    params.require(:registration).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def clerk_sdk
    Clerk::SDK.new(secret_key: ENV.fetch("CLERK_SECRET_KEY"))
  end
end
