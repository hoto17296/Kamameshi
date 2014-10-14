class UserController < ApplicationController
  before_filter :authenticate_user!, except: [:login]

  def index
  end

  def login
  end

end
