class User < ApplicationRecord
  include Discard::Model

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

   def self.from_omniauth(auth)
     puts "1" * 20
     puts auth.extra.raw_info.birthday
     puts auth.extra.raw_info.birthday.to_s.to_date
     puts auth.extra.raw_info.birthday.to_s
     puts auth.extra.raw_info.birthday.to_date
     birthday = auth.extra.raw_info.birthday.to_date
     puts "2" * 20
     puts birthday
     user_age(birthday)
     return "younger" if user_age(birthday) < 18
     puts "3" * 20

     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.email = auth.info.email
       user.password = Devise.friendly_token[0,20]
       user.name = auth.info.name
       user.image = auth.info.image
       user.birthday = Dates.brazilian(birthday)
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

  def user_age(birthday)
    age = Date.today.year - birthday.year
    age -= 1 if Date.today < birthday + age.years
    age
  end
end
