class IdeasController < ApplicationController
  	def index
  		@user = User.find(session[:user_id])
  		@users = User.all
  		@ideas = Idea.all
  		@likes=Like.all

  
  	

  	end

	def create    
	    @user = User.find(session[:user_id])
	    @ideas = Idea.all
	    @idea = Idea.create(content:params[:content], user:User.find(session[:user_id]))
	      if @idea.valid?
	            @idea.save
	            redirect_to '/ideas'
	      else
	            flash[:errors] = @idea.errors.full_messages
	            redirect_to :back
	      end 
	end

	def like
		@user = User.find(session[:user_id])
	    @idea = Idea.find(params['idea_id'])
	    @like = Like.create(user_id:@user.id, idea_id:@idea.id)

	    redirect_to '/ideas' 
	end

	def show
		@idea=Idea.find(params[:id])
  		@ideas=Idea.all
  		@user = User.find(session[:user_id])
  		@users=User.all
  		@likes=Like.all
  		@who_liked = Like.where(idea_id: @idea)
	end


	def destroy
      idea = Idea.find(params[:id])
      idea.destroy
      redirect_to :back 
    end 
end