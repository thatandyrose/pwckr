class PhotosController < ApplicationController
  def search
    @query = params[:query]
    @page = params[:page] ? params[:page].to_i : 1
  end
end
