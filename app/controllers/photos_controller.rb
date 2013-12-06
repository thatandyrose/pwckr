class PhotosController < ApplicationController
  
  def list
    @query = params[:query]
    @page = params[:page] ? params[:page].to_i : 1
    @page_size = params[:page_size] ? params[:page_size].to_i : 20

    if params[:do_search] == 'true'
      @photos = Photo.text_search(params[:query],@page,@page_size)
      @page += 1
    else
      @photos = []
    end

    if params[:id]
      @photo = Photo.find(params[:id])
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end
end
