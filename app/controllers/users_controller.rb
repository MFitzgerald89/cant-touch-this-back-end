class UsersController < ApplicationController

  def create
    @user = User.create!(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation], city: params[:city],
      state: params[:state]
    )

    if @user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { message: @user.errors.full_messages }, status: :bad_request
    end

  end

  def show

    @user = User.find_by(id: params[:id])

    if @user == current_user
      render json: @user
    else
      render json: { errors: "Not Authorized"}, request: :bad_request
    end
    
  end

  def update

    @user = User.find_by(id: params[:id])

    if @user == current_user

      @user.update(
        first_name: params[:first_name] || @user.first_name,
        last_name: params[:last_name] || @user.last_name,
        email: params[:email] || @user.email,
        city: params[:city] || @user.city,
        state: params[:state] || @user.state
      )
      render json: @user, status: 200
    
    else
      render json: { errors: "Not Authorized" }, status: 401

    end
  
  end

  def destroy

    @user = User.find_by(id: params[:id])

    if @user == current_user

      @user.destroy
      render json: {message: "User Removed" }, status: 200

    else
      render json: { errors: "Not Authorized" }, status: 401

    end

  end

end
