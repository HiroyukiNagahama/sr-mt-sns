class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :is_manager, only: [:create,:destroy_record]

  def index
    find_records
  end

  def create
    render 'edit'
  end

  def edit
    find_record if @user.nil?
  end

  def save
    if params[:user][:id] != current_user.id && !current_user.manager
      flash[:notice] = '他人の情報を書き換えないでください'
    end
    user = User.find_or_initialize_by(id: params[:user][:id])
    if user.id && params[:user][:password].blank?
      user.attributes = user_params.delete_if{|key,value|key == "password"||key == "password_confirmation"}
    else
      user.attributes = user_params
    end

    user.manager = (params[:manager] ? true : false) if current_user.manager

    if user.save
      redirect_to action: :index and return
    else
      flash[:notice] = user.errors.full_messages
      @user = user
      render action: :edit
    end

  end

  def destroy_record
    u = find_record
    if u.destroy
      flash[:alert] = "削除しました"
    else
      flash[:alert] = '削除に失敗しました'
    end
    find_records
    render '/home/index'
  end

  def import_csv
    if request.post?
      require "csv"
      require 'kconv'
      alreadys = []
      arr_of_arrs = CSV.parse(Kconv.toutf8(params[:dump][:file].read))
      arr_of_arrs.each_with_index do |r,ind|
        next if ind == 0
        if User.exists?(email: r[2])
          alreadys << r[1]
          next
        end
        set_password = r[2].sub(/@.+/,'123456789')
        user = User.new(code: r[0],name: r[1],email: r[2],password: set_password,password_confirmation: set_password,manager: r[3])
        user.save!
      end
      flash[:error] = alreadys.unshift("下記該当者はすでに登録されています")
    end
  end

  private
  def find_records
    @users = User.all.order(:name)
  end

  def find_record
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(
        :id, :name, :code, :email, :password,:password_confirmation)
  end

end
