class UsersController < ApplicationController
  require 'csv'
  helper_method :sort_column, :sort_direction
  before_action :user_values
  include UsersHelper
  protect_from_forgery except: :edit
  before_action :find_user, only: %i[edit update destroy]

  def new 
    @stand_up = User.new
    @users = User.all.order("created_at desc")
  end

  def index
    if params[:sort] == nil
      @users = @users.order("created_at desc")
    else
      @users = User.order(sort_column + " " + sort_direction)
    end
    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(@users), filename: "standup-listings.csv" }
    end
  end

  def edit;end

  def create
    @stand_up = User.new(user_params)
    if @stand_up.save
      redirect_to root_path
    else
      redirect_to root_path
      flash[:error] = "Please enter values"

    end
  end

  def update
    if @user.update(user_params)
      respond_to do |format|
        format.html
        format.js
        redirect_to root_path
      end
    else
      flash[:error] = "Something went wrong"
      redirect_to root_path
    end
  end


  def destroy
    if @user.destroy
      respond_to do |format|
        format.html
        format.js
        flash[:notice] = "Work Log has been deleted."
      end
    else
      flash[:error] = "Something went wrong"
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_values
    @users = User.where('lower(name) LIKE ?', "%#{search_value}%").order("created_at desc", sort_column + " " + sort_direction)
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def search_value
    params["search"] ||= ''
    params["search"].downcase
  end

  def user_params
    params.require(:user).permit(:name, :start_at, :end_at)
  end

end
