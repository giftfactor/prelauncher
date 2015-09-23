class UsersController < ApplicationController
  def new
    redirect_if_already_registered

    ref_code = params[:ref_code] || params[:fb_ref]
    cookies.permanent.signed["ref_code"] = ref_code
  end

  def create
    @user = find_or_create_from_oauth
    referring_user.add_referral(@user.email)
    cookies.permanent.signed["user_id"] = @user.id
    SubscriptionsWorker.new.async.perform(@user.id)
    redirect_to referrals_path
  end

  def refer
    @user = User.where(id: cookies.signed["user_id"]).first
    @share_message = 'Looks Like I’ll Always Be Giving Great Gifts From Now On! Check it Out: Data-Based Gift Suggestions:'
    if !@user.nil?
      @referral_code = @user.referral_code
    else
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_url,
      :alert => "Authentication error: #{params[:message].humanize}"
  end

  private

  def find_or_create_from_oauth
    auth = request.env["omniauth.auth"]
    identity = Identity.find_from_oauth(auth)
    if identity
      user = identity.user
    else
      user = User.create(
        email: auth['info']['email'],
        first_name: auth['info']['first_name'] || '',
        last_name: auth['info']['last_name'] || '',
      )
      user.identities.create_from_oauth(auth)
    end
    user
  end

  def redirect_if_already_registered
    if cookies.signed["user_id"]
      already_registered = User.where(id: cookies.signed["user_id"]).first
      if already_registered
        redirect_to referrals_path
      else
        cookies.delete("user_id")
      end
    end
  end

  def referring_user
    ref_code = cookies.permanent.signed["ref_code"]
    User.where(referral_code: ref_code).first || Naught.build.new
  end

end
