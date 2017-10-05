class UsersController < ApplicationController

get '/signup' do
  if session[:user_id]
    redirect to '/tweets'
  else
    erb :'users/create_user'
  end
end

post '/signup' do
  if params[:username] == "" || params[:email] == "" || params[:password] == ""
    redirect to '/signup'
  else
    @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    @user.save
    session[:user_id] = @user.id
    redirect to '/tweets'
  end
end

get '/login' do
  if session[:user_id]
    redirect to '/tweets'
  else
    erb :'users/login'
  end
end

post '/login' do
  user = User.find_by(:username => params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to "/tweets"
  else
    redirect to '/signup'
  end
end


end
