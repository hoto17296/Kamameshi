class UserController < ApplicationController
  before_action :authenticate_user!, except: [:login]

  def index
    # イベント開催中かつ出欠未回答なら回答ページにリダイレクト
    redirect_to :participate if Event.inviting? and not current_user.replied?
    @event = Event.recent.first
    @reply = current_user.reply @event
  end

  def login
    render layout: false
  end

  # 回答ページ
  def participate
    @event = Event.current.first
    redirect_to :root if @event.nil?
    @reply = current_user.reply @event

    if request.post?
      @reply = UserGroup.new reply_params
      @reply.user = current_user
      @reply.event = @event
      if @reply.save
        redirect_to :root, notice: '回答を受け付けました'
      end
    elsif request.patch?
      if @reply.update reply_params
        redirect_to :root, notice: '回答を更新しました'
      end
    else
      @reply = UserGroup.new if @reply.blank?
    end
  end

  private
    def reply_params
      params.require(:user_group).permit(:is_participant, { answers: [] })
    end

end
