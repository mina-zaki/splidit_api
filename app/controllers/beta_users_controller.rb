class BetaUsersController < ActionController::Base


  def new
    @beta_user = BetaUser.new
    render :new
  end

  def create
    @beta_user = BetaUser.new(permitted_params[:beta_user])
    if @beta_user.save
      redirect_to success_beta_users_path
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

end