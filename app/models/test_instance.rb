require 'prime'

class TestInstance < ApplicationRecord

  # ----------------------------------------
  # TESTINSTANCE: a test taken by a test_taker user and corrected by an examiner user.
  # ----------------------------------------

  ## Relations

  # Every kind of of test instance will have at least 2 users ( a test taker and an examiner )
  # But an user can also have many test_instances assigned to it
  # A good way to get throught many to many associations is to have a third table.
  has_many :user_test_instances
  has_many :users, through: :user_test_instances

  ## Attributes

  # Language of the test instance, there is no default language assigned
  # Usually 0 is used for default setting, so it start from 1.
  enum test_language: {
    en: 1,
    fr: 2,
    de: 3,
    it: 4,
    es: 5
  }

  private

  def update_hash
    status_hash = Time.now.to_i if status_hash.nil?

    update(status_hash: Prime.prime_division(Time.now.to_i*status_hash*rand(status_hash)).last.first)
  end

end
