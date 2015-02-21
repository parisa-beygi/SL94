class RegistrationsController < Devise::RegistrationsController

  include ApplicationHelper

  before_action :set_date_select, [:create, :update]

  def create
    build_resource(sign_up_params)

    persian_date = JalaliDate.new(persian_to_english_num_string(params[:birth_year]).to_i,params[:birth_month].to_i,
                                  persian_to_english_num_string(params[:birth_day]).to_i)
    resource.birth_date = persian_date.to_g

    #if((Date.today.year * 12 + Date.today.month) - (persian_date.to_g.year * 12 + persian_date.to_g.month) < 12 * 8)
    #  redirect_to :back , :alert => 'باید سن شما بیشتر از ۸ سال باشد'

    if resource.save
        # Tell the UserMailer to send a welcome email after save
       #
        @user=resource
       # UserMailer.welcome_email(@user).deliver

      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        respond_with resource, :location => after_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  private
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :birth_date, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :birth_date, :email, :password, :password_confirmation, :current_password)
  end

  def set_date_select
    @years = Hash.new
    ((persianNumber('1300', 'fa')..persianNumber('1393','fa')).to_a.reverse).to_a.each { |e| @years[e] = e }
    @days = Hash.new
    (persianNumber('1', 'fa')..persianNumber('31','fa')).to_a.each { |e| @days[e] = e }
    @months = Hash.new
    @months = { 1 => 'فروردین ',2 => 'اردیبهشت',3 => 'خرداد' ,4 => 'تیر',5 => 'مرداد' ,6 => 'شهریور' ,7 => 'مهر'  ,8 => 'آبان' ,9 => 'آذر'  ,10 => 'دی' ,11 => 'بهمن' ,12 => 'اسفند'}
  end


end