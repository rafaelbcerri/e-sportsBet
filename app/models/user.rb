class User < ApplicationRecord
  include Discard::Model
  include DateHelper

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

   def self.from_omniauth(auth)
     birthday = auth.extra.raw_info.birthday.to_date
     return "younger" if user_age(birthday) < 18

     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.email = auth.info.email
       user.password = Devise.friendly_token[0,20]
       user.name = auth.info.name
       user.image = auth.info.image
       user.birthday = brazilian_date(birthday)
     end
   end

   default_scope { kept }

   def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
