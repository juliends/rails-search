class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    word = params[:search] 
    unless word.nil?
      @movies = PgSearch.multisearch(word).page(params[:page]).per(3)
    end
    respond_to do |format|
      format.html
      format.js # home.js.erb
    end
  end
end
