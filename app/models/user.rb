class User < ApplicationRecord
  include Discard::Model

  before_create :age_restriction

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  default_scope { kept }

  after_create :send_admin_mail

  def self.from_omniauth(auth)
   birthday = Date.strptime(auth.extra.raw_info.birthday, '%m/%d/%Y')
   return "younger" if user_age(birthday) < 18

   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
     user.name = auth.info.name
     user.image = auth.info.image
     user.birthday = auth.extra.raw_info.birthday
   end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.user_age(birthday)
    age = Date.today.year - birthday.year
    age -= 1 if Date.today < birthday + age.years
    age
  end

  protected

  def send_admin_mail
    UserMailer.new_user_message(self).deliver
  end

  def age_restriction
    if (self.birthday.to_date + 18.years) > Date.today
      errors.add :birthday, 'must be older than 18'
    end
  end
end
