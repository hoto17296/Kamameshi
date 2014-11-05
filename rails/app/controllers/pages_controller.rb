class PagesController < ApplicationController
  before_action :authenticate_admin, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @pages = Page.all
    respond_with(@pages)
  end

  def show
    respond_with(@page)
  end

  def new
    @page = Page.new
    respond_with(@page)
  end

  def edit
  end

  def create
    @page = Page.new(page_params)
    @page.save
    respond_with(@page)
  end

  def update
    @page.update(page_params)
    respond_with(@page)
  end

  def destroy
    @page.destroy
    respond_with(@page)
  end

  def map
  end

  def qa
  end

  private
    def set_page
      @page = Page.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:body, :permalink, :is_public)
    end
end
