class GroupsController < ApplicationController
  before_action :authenticate_admin
  before_action :set_event
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new
    @group.event = @event
    @group.attributes = group_params

    if @group.save
      @group.destroy if @group.user_groups.size == 0
      redirect_to @event, notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def update
    @group.leader = nil
    if @group.update(group_params)
      @group.destroy if @group.user_groups.size == 0
      redirect_to @event, notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'グループを削除しました'
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      user_group_ids = params[:group][:member_ids]
      user_group_ids = [] if not request.get? and user_group_ids.nil?
      unless user_group_ids.nil?
        @group.user_groups.clear
        user_group_ids.each do |user_group_id|
          @group.user_groups << UserGroup.find(user_group_id)
        end
      end
      params.require(:group).permit(:iqube_url, :leader_id)
    end
end
