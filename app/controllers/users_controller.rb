class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "Usuário cadastrado com sucesso!"
    else
      render :new, alert: "Erro ao cadastrar usuário."
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: "Usuário atualizado com sucesso!"
    else
      render :edit, alert: "Erro ao atualizar usuário."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
