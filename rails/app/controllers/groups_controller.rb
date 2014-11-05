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
      if not request.get? and params[:group][:member_ids].nil?
        params[:group][:member_ids] = []
      end
      unless params[:group][:member_ids].nil?
        @group.user_groups.clear
        params[:group][:member_ids].each do |member_id|
          @group.user_groups << UserGroup.find(member_id)
        end
      end
      params.require(:group).permit(:iqube_url, :leader_id)
    end
end
