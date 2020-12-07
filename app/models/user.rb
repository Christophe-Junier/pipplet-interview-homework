# frozen_string_literal: true

# ----------------------------------------
# USER: Users of the application
# ----------------------------------------
class User < ApplicationRecord
  ## Relations

  # Every kind of user can have 0 to infinite numbers of tests
  # But a test_instance can also have many users assigned to it, like a test_taker and an examiner
  # A good way to get throught many to many associations is to have a third table.
  has_many :user_test_instances
  has_many :test_instances, through: :user_test_instances

  ## Validations

  validates :name, presence: true
  validates :email, presence: true
  validates :role, presence: true
  validates :language, presence: true

  ## Scopes

  # Basic scope to retrieve a type of user
  scope :test_takers, -> { where(role: 0) }
  scope :admins,      -> { where(role: 1) }
  scope :examiners,   -> { where(role: 2) }

  ## Attributes

  # Role of the user -> default is test_taker (database setup)
  enum role: {
    test_taker: 0,
    admin: 1,
    examiner: 2
  }

  # Spoken and written language of an user, default would be 'en' for internationalization purpose (database setup)
  # Using a prefix to not conflict with expert_language attribute.
  # Enum generated method will then be: speak_(enum)?
  enum language: {
    en: 0,
    fr: 1
  },
       _prefix: :speak

  # ----------------------------------------
  # EXAMINER
  # ----------------------------------------

  ## Scopes

  # Examiner which can take a test instance
  # validated can take as much as test instance
  # pending validation can only take a maximum of 3 test instance
  scope :can_take_test_instance, lambda {
                                   where(status: 0,
                                         test_instance_count: [0, 1, 2])
                                     .or(where(status: 1))
                                 }

  ## Attributes

  # Status of an examiner user -> default is pending_validation (model callback)
  enum status: {
    pending_validation: 0,
    validated: 1,
    rejected: 2
  }

  # Expertise language of an examiner user, there is no default language assigned
  # Usually 0 is used for default setting, so it start from 1, doing this,
  # if a default language is later needed, it could be 0
  enum expert_language: {
    en: 1,
    fr: 2,
    de: 3,
    it: 4,
    es: 5
  }

  ## methods

  # Given an users relation, it return the user with the lower number of test on the past 7 days
  def self.user_lower_nb_test(record_of_users)
    # An array that will contain user with their number of test associated
    # example: [ {user: user, nb_of_test: n } ]
    user_and_nbs_of_test_array = []

    # Iterating over records of users to fill our array
    record_of_users.each do |user|
      last_seven_day_number_of_tests = user.test_instances.where(created_at: 7.days.ago..DateTime.now).count
      user_and_nbs_of_test_array << { user: user, nb_of_test: last_seven_day_number_of_tests }
    end

    # Sorting the array by number of test
    user_and_nbs_of_test_array.sort_by! { |hash| hash[:nb_of_test] }

    # Returning the first user
    user_and_nbs_of_test_array.first[:user]
  end
end
