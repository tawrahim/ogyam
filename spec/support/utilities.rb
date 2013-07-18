include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "email", with: user.email
  fill_in "password", with: user.password 
  click_button "Sign in"
  cookies[:remember_token] = user.remember_token
end

