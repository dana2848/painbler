require 'sinatra'
require 'sinatra/activerecord'
enable :sessions

# set :database, "sqlite3:project-name.sqlite3"
ActiveRecord::Base.establish_connection(ENV['DATABSE_URL'])

get '/' do
   p 'we did it!'
   @user = User.all
   p @users
   erb :home
end

get '/login' do
  erb :login
end



# post '/login' do
#    @email = params[:email],
#    @password = params[:password]
#    # p "your account name is #{params['email']}"
#    # p "your account name is #{params['password']}"
#    redirect :account
# end

get '/account' do
  # @user = User.find(session[:user_id])
  # p '====='
  # p @user
  # p '====='
  erb :account
end

post '/account' do
  post = Post.create(
    title: params['title'],
    body: params['body'],
    user_id: session[:user].id
  )
 post.save
  redirect '/account'
end

post '/posting' do
  @title = params["title"]
  @message = params["message"]
  erb :posting
end



get '/signup' do
  erb :signup
end

get '/home' do
  erb :home
end




post '/home' do

   user = User.new(
     email: params['email'],
     name: params['name'],
     password: params['password']
   )
  user.save
  # session[:user_id] = user.id
  redirect '/home'
end

post '/login' do
   email = params['email']
   given_password = params['password']
   #check is email exists
   #check to see if the email has a password == form PASSWORD
   #if match, login user
   user = User.find_by(email: email)
   if user.password == given_password
      session[:user] = user
      redirect :account
    else
      p 'wrong credentials'
      redirect '/home'
  end
end

get '/logout' do
  session[:user_id] = nil
  p "user has logged out"
  redirect '/'
end

get '/deleteaccount' do
  erb :deleteaccount
end

post '/deleteaccount' do
 User.find(session[:user].id).destroy
 session[:user] = nil
 redirect '/'
end


require './models'
