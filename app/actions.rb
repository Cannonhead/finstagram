helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end
end    

get '/' do
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
  erb(:index)
end

get '/signup' do
  @user = User.new  
  erb(:signup) # render app/views/signup.erb
end  


post "/signup" do
  
   # grab user input values from params
  email = params[:email]
  avatar_url = params[:avatar_url]
  username = params[:username]
  password = params[:password]

    # instantiate and save user information
    @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password})
    
  # checks if user credentials present and saved
  if @user.save
    redirect to('/login')
  else
    erb(:signup) 
  end
end

get '/login' do
  erb(:login)     # render app/views/login.erb
end 

post '/login' do  # when we submit a form with an action of /login
  username = params[:username]
  password = params[:password]

  @user = User.find_by(username: username)

    if @user && @user.password == password 
      session[:user_id] = @user.id   
      redirect to('/')
    else
      @error_message = "Login failed."
      erb(:login)
    end
end

    get '/logout' do
      session[:user_id] = nil
      redirect to('/')
    end      

    get '/' do
      @finstagram_posts = FInstagrampost.order(created_at: :desc)
      @current_user = User.find.by(id: session[:user_id])
      erb(:index)
    end  