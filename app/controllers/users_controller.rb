class UsersController < ApplicationController
  before_filter :signed_in_user, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user,   :only => [:edit]
  before_filter :admin_user,     :only => [:destroy]

  def index
    @users = User.paginate(page: params[:page], :per_page => 10)
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], :per_page => 10)
  end
  def new
    @user = User.new
  end


  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    # if current_user != User.find(params[:id])
    #   redirect_to signin_path
    #   flash[:error] = "Please sign in to access this page"
    # else
      # @user = User.find(params[:id])
    # end
  end

  def update
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Destroyed"
    redirect_to users_path
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end

    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end

end
