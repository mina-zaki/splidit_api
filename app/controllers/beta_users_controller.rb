require 'mailchimp'

class BetaUsersController < ActionController::Base

  after_filter :allow_iframe
  layout 'application'

  def new
    @beta_user = BetaUser.new
    render :new
  end

  def create
    @beta_user = BetaUser.new(permitted_params)
    if @beta_user.valid?
      mailchimp = Mailchimp::API.new(MAILCHIMP_API_KEY)
      begin
        raise ""
        mailchimp.lists.subscribe(MAILCHIMP_LIST_ID, {email: @beta_user.email}, {FNAME: @beta_user.first_name, LNAME: @beta_user.last_name}, double_optin = false, send_welcome = false, update_existing = true)
        @beta_user.save
        redirect_to success_beta_users_path
      rescue Mailchimp::Error => e
        if e.message.include?("is an invalid email address")
          @beta_user.errors.add(:email, "Invalid email address, please enter a valid email")
        else
          @beta_user.errors.add(:base, e.message)
        end
      rescue StandardError => e
        @beta_user.errors.add(:base, e.message)
      ensure
        render :new
      end
    else
      render :new
    end
  end

  def success

  end


  private


  def permitted_params
    params.require(:beta_user).permit(:first_name, :last_name, :email)
  end


  def allow_iframe
    response.headers.delete "X-Frame-Options"
  end

end