class PhotosController < ApplicationController

  def new
    @album = Album.find(params[:album_id])
  end

  def create
    photo = Photo.new(params[:photo])
    respond_to do |format|  
      if photo.save  
        format.html {  
          render :json => [photo.to_json_picture].to_json,  
          :content_type => 'text/html',  
          :layout => false  
        }  
p photo.to_json_picture
        format.json { render json: {files: [photo.to_json_picture]}, status: :created, location: photo }  
      else  
        format.html { render action: "new" }  
        format.json { render json: photo.errors, status: :unprocessable_entity }  
      end  
    end 
  end
  def destroy  
    @photo = Photo.find(params[:id])  
    @photo.destroy  
  
    respond_to do |format|  
      format.html { redirect_to photo_url }  
      format.json { head :no_content }  
    end  
  end

end
