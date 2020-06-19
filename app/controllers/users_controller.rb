class UsersController < ApplicationController
  before_action :authenticate_user, only: [:edit, :index, :show, :update]
  before_action :forbid_login_user, only: [:new, :create, :login, :confirm]
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name], email: params[:email], password:params[:password], image_name: "default_user.jpg")
    if @user.save
      flash[:notice] ="新規登録を完了しました"
      session[:user_id] = @user.id
      redirect_to("/users/index")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_image/#{@user.image_name}",image.read)
    end
    if @user.save
      flash[:notice] ="ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login
  end

  def confirm
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate("#{params[:password]}")
      flash[:notice] ="ログインが完了しました"
      session[:user_id] = @user.id
      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトが完了しました"
    redirect_to("/")
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end


end
