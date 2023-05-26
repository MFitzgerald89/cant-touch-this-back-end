class UsersController < ApplicationController

  def create
    user = User.create!(
      first_name: params[:first_name],
      last_name: params[:last_name],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )

  end

end
