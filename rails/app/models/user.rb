class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_groups

  POST_LIST = ['ADMIN','PRD','AIRY','OCD','SG','CSD','WI','FOS','SOC','MOBA','BMD','ZEN','RND','CMSS','IQ','XS','NTC','その他']

  def self.post_options
    POST_LIST.each_with_index.map {|i, post| [ i, post ] }
  end

  def self.find_for_google_oauth2(auth)
    user = User.where(email: auth.info.email).first
    unless user
      user = User.create(
        name:     auth.info.name,
        provider: auth.provider,
        uid:      auth.uid,
        email:    auth.info.email,
        token:    auth.credentials.token,
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  def post
    post_id.nil? ? nil : POST_LIST[post_id]
  end

  def admin?
    is_admin
  end

  def reply(event = nil)
    event = Event.current.first if event.nil?
    return nil if event.nil?
    UserGroup.where(user_id: id, event_id: event.id).first
  end

  def replied?(event = nil)
    reply(event).present?
  end

end
