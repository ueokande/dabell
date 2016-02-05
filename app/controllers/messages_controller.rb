class MessagesController < ApplicationController
  protect_from_forgery except: :index
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  after_action :update_read_to, only: [:index]

  def index
    @messages = if params[:max_id].present?
                  Message.where('id <= ?', params[:max_id]).last(25)
                else
                  Message.last(25)
                end
    render
  end

  def show
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      render :show, status: :created, location: @message
      MessageBroadcastJob.perform_later(method: 'create', message: @message)
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @message.destroy
    MessageBroadcastJob.perform_later(method: 'destroy', id: @message.id)
    head :no_content
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:text, :user_id)
  end

  def update_read_to
    return if @messages.empty? || current_user.read_to >= @messages.last.id
    current_user.update(read_to: @messages.last.id)
  end
end
