class User < ApplicationRecord
  enum :access_level, { client: 0, manager: 1 }
end
