class LibraryController < ApplicationController
  def index
    @results = Library.all
    respond_to do |format|
      format.html
      format.js {}
    end
  end

  def search
    @results = Library.search(params[:search])
    render :index
  end
end
