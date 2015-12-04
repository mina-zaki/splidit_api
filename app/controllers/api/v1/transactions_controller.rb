class Api::V1::TransactionsController < ApplicationController

  before_filter :authenticate_user!

  def create
    conversation = current_user.conversations.find(params[:conversation_id])
    @other_user = conversation.users.find(permitted_params[:user_id])
    return api_error(:user => "Wrong user") if @other_user.eql?(current_user)
    amount = permitted_params[:amount].to_d
    success, result = TransactionServiceObject.create(current_user,@other_user,amount,conversation)
    if success
      render :json => {:post => PostSerializer.new(result),:user =>{:balance => current_user.balance}} and return
    end
    return api_error(result)
    #TODO handle errors
  end


  private


  def permitted_params
    params.require(:transaction).permit(:user_id,:amount)
  end


end