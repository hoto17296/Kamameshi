class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    omniauth_env = request.env['omniauth.auth']
    @user = User.find_for_google_oauth2(omniauth_env)

    # 一般のGmailアカウントからのログインをブロック
    # TODO このへんもっとちゃんと書く
    if omniauth_env.info.email.match /@gmail\.com$/
      render text: "Sorry, this account(#{omniauth_env.info.email}) is invalid.", status: 403
    elsif @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
    else
      session['devise.google_data'] = omniauth_env
      redirect_to new_user_registration_url
    end
  end
end
