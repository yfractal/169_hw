class SessionsController < ApplicationController
  # user shouldn't have to be logged in before logging in!
  skip_before_filter :set_current_user
  def create
    auth = request.env["omniauth.auth"]
    user = Moviegoer.find_by_provider_and_uid(auth["provider"], auth["uid"]) ||
          Moviegoer.create_with_omniauth(auth)
    if session[:user]
      # merge two account
      if session[:uer] != user 
        # same user come frome two different web site
        i = Identity.find(session[:user].identity_id)
        i_t  = Identity.find(user.identity_id)

        i.moviegoers << user 
        i.save!
        i_t.destroy
        
      end
    end
     session[:user] = user
     session[:user_id] = user.id

     redirect_to movies_path
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to movies_path
  end
end