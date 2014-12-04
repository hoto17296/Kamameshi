class UserController < ApplicationController
  before_action :authenticate_user!, except: [:login]

  def index
    # イベント開催中かつ出欠未回答なら回答ページにリダイレクト
    redirect_to :enquete_before if Event.inviting? and not current_user.replied?
    @event = Event.recent.first
    @reply = current_user.reply @event
  end

  def login
    render layout: false
  end

  # 回答ページ
  def enquete_before
    @event = Event.current.first
    redirect_to :root if @event.nil?

    @reply = current_user.reply @event
    if @reply.blank?
      @reply = UserGroup.new
      @reply.is_participant = 1
      @reply.user = current_user
    end

    if request.post?
      @reply = UserGroup.new reply_params
      @reply.user = current_user
      @reply.user.update user_params
      @reply.event = @event
      if @reply.save
        redirect_to :root, notice: '回答を受け付けました'
      end
    elsif request.patch?
      @reply.user.update user_params
      if @reply.update reply_params
        redirect_to :root, notice: '回答を更新しました'
      end
    else
      @reply = UserGroup.new if @reply.blank?
    end
  end

  def enquete_after
    # TODO 事後アンケート募集前ならリダイレクト
    # TODO 参加者でなければリダイレクト
    # TODO 既に回答済みであればリダイレクト
    # TODO POSTだったら保存してリダイレクト or エラー画面
  end

  private
    def reply_params
      params.require(:user_group).permit(:is_participant, { answers: [] })
    end

    def user_params
      params.require(:user).permit(:post_id, :skype_id)
    end
end
