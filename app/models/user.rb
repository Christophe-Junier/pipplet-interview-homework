class User < ApplicationRecord

  # ----------------------------------------
  # :section: Roles
  # ----------------------------------------
  # Default is test_taker (database setup)
  enum role: {
    test_taker: 0,
    admin: 1
  }

end
