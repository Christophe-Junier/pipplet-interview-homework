class UserTestInstance < ApplicationRecord

  # ----------------------------------------
  # USERTESTINSTANCE: a joining table matching test_instances and users.
  # ----------------------------------------

  ## Relations

  # An user test instance is the link between users and test instances
  # That way every user_test_instance belong to an user and a test instance
  belongs_to :user
  belongs_to :test_instance

end
