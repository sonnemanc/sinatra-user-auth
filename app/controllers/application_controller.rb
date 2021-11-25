class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    # your code here
    erb:home
  end

  get '/registrations/signup' do
    # your code here
    erb:'/registrations/signup'
  end

  post '/registrations' do
    # your code here
    @user = User.new(name: params['name'], email: params['email'], password: params['password'])
    @user.save
    session[:user_id] = @user.id

    redirect '/users/home'
  end

  get '/users/home' do
    # your code here
    @user = User.find(session[:user_id])
    erb :'/users/home'
  end

  get '/sessions/login' do
    # the line of code below render the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end

  get '/sessions/logout' do
    # your code here
    session.clear
    redirect '/'
  end

end
