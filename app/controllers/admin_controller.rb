class AdminController < ApplicationController

  layout 'admin'

  def index

  end

  def create
    @admin = Admin.find_by(email: params[:email])
    if  @admin.present? && (params[:password] == params[:password_confirmation]) && @admin.valid_password?(params[:password]) && @admin.valid_password?(params[:password_confirmation])
      phone_number = params[:phone].sub(/\A./,'+81')
      sms_number = rand(10000..99999)
      session[:sms_number] = sms_number
      client = Twilio::REST::Client.new(ENV["TWILLIO_SID"],ENV["TWILLIO_TOKEN"])

      begin 
        client.api.account.messages.create(from: ENV["TWILLIO_NUMBER"], to: phone_number, body: sms_number)
      rescue
        render "admin/index"
        return false
      end
      session[:email] = params[:email]
      session[:password] = params[:password]
      session[:password_confirmation] = params[:password_confirmation]
      redirect_to sms_confirmation_admin_index_path
    else
      render "admin/index"
      return false
    end
  end

  def sms_confirmation
  end

  def sms_check
    unless session[:email].present? && session[:password].present? && session[:password_confirmation].present? && params[:sms_num].present?
      redirect_to admin_index_path
      return false
    end

    if session[:sms_number] == params[:sms_num].to_i
      @admin = Admin.find_by(email: session[:email])
      if @admin.present? && @admin.valid_password?(session[:password]) && @admin.valid_password?(session[:password_confirmation])
        reset_session
        sign_in @admin
        redirect_to admin_posts_path(current_admin)
      else
        reset_session
        redirect_to admin_index_path
      end
    else
      render "admin/sms_confirmation"
      return false
    end
  end

  def sign_out
    if admin_signed_in?
      reset_session
    end
    redirect_to root_path
  end

end
