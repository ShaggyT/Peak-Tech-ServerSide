class Api::V1::UsersController < Api::ApplicationController
  before_action :authenticate_user!, except: [:create]
  before_action :find_user, only: [:show, :destroy, :update]

    def show
      render json: @user
    end

    def create
      user = User.new(user_params)

      if user.save
        render json: { id: user.id }
      else
        render json: { error: user.errors.full_messages }
      end
    end

    def update
      if @user.update user_params
        render json: @user
      else
        render json: { error: @user.errors.full_messages }
      end
    end

    def destroy
      if @user.destroy
        render json: { message: 'Successfully deleted!!!' }
      else
        head :bad_request
      end
    end


  private

  def find_user
    @user = current_user
  end

  def user_params
     params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
