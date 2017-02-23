class UsersController < ApplicationController
  	def index
  	@users=User.all
  	@user =  User.find(params[:id])
  	@idea=Idea.find(params[:_id])
  	@ideas = Idea.all
  	@ideas_of_user = Idea.where(user_id: @user)
  	@likes = Like.all
  	@who_liked = Like.where(idea_id: @ideas_of_user)	

  	end

  	def new
  	end

    def create
    	if !session[:user_id]
   			 @user = User.create(name:params[:name],alias:params[:alias],email:params[:email],password:params[:password],password_confirmation:params[:password_confirmation])
	  			if @user.valid?
	  				@user.save
	  				session[:user_id] = @user.id
	  				redirect_to '/ideas'
	  			else
	  		 	flash[:errors] = @user.errors.full_messages
      			redirect_to :back
	  			end 
	  	end 
  	end



  	def login

      user = User.find_by_email(params[:email])

        if user && user.authenticate(params[:password])
        
          session[:user_id] = user.id
          redirect_to '/ideas'
        else
          flash[:errors] = ["Invalid combination"]
          redirect_to '/users/new'
        end
    end

  	def logout
      session[:user_id] = nil
      redirect_to '/'
    end
end