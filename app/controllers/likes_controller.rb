class LikesController < ApplicationController
  	def index

  	end

  def destroy
    like = Like.find(params[:id]).destroy
    redirect_to :back
  end 
end
