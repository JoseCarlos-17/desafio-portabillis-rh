class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

    enum :access_level, { client: 0, manager: 1 }
end
