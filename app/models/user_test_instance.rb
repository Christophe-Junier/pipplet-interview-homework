# frozen_string_literal: true

# ----------------------------------------
# USERTESTINSTANCE: a joining table matching test_instances and users.
# ----------------------------------------
class UserTestInstance < ApplicationRecord
  ## Relations

  # An user test instance is the link between users and test instances
  # That way every user_test_instance belong to an user and a test instance
  # Important ! the test instance count will automatically increase the column test_instance_count of the user_model
  # That way we can later, easely get users that got less than 3 test_instance
  belongs_to :user, counter_cache: :test_instance_count
  belongs_to :test_instance
end
