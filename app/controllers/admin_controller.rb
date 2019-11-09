class AdminController < ApplicationController
  before_action :redirect_to_admin_index, except: [:index,:sms_confirmation]
  layout 'admin'

  def index

  end

  def create

  end

  def sms_confirmation

  end

  def sms_check

  end

  private

  def admin_params

  end

  def redirect_to_admin_index
    redirect_to admin_index_path unless admin_signed_in?
  end
end
