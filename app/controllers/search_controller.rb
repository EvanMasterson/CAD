class SearchController < ApplicationController
  before_action :authenticate_admin!
  
  def authenticate_admin!
    redirect_to(root_path) unless current_user.admin
  end
  
  def index
    if params[:search]
      @results = User.search(params[:search]).order('email')
    end
  end
end
