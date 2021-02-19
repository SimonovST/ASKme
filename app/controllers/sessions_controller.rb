class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])

    if @user.present?
      session[:user_id] = @user.user_id
      redirect_to root_url, notice: 'Вы успешно залогинелись'
    else
      flash.now.alert = 'Не правильно набран Email и пароль'
      render :new
    end
  end

  def destroy
  end
end

