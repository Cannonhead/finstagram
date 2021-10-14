get '/' do
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
  erb(:index)
end

get '/signup' do
  @user = User.new  
  erb(:signup)
end  

post "/signup" do
  
   # grab user input values from params
  email = params[:email]
  avatar_url = params[:avatar_url]
  username = params[:username]
  password = params[:username]

    # instantiate and save user information
    @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password})
    
  # checks if user credentials present and saved
  if @user.save
    "User #{username} saved!"
  else
    erb(:signup) 
  end

end