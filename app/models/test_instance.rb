require 'prime'

class TestInstance < ApplicationRecord

  # ----------------------------------------
  # TESTINSTANCE: a test taken by a test_taker user and corrected by an examiner user.
  # ----------------------------------------

  ## Relations

  # Every kind of of test instance will have at least 2 users ( a test taker and an examiner )
  # But an user can also have many test_instances assigned to it ( like an examiner user )
  # A good way to get throught many to many associations is to have a third table.
  has_many :user_test_instances
  has_many :users, through: :user_test_instances

  # Callbacks

  # Assign an examiner to a test instance before its save.
  before_create :assign_examiner
  # Update the status hash after creation

  ## Validations

  validates :language, presence: true

  ## Attributes

  # Language of the test instance, there is no default language assigned
  # Usually 0 is used for default setting, so it start from 1.
  enum language: {
    en: 1,
    fr: 2,
    de: 3,
    it: 4,
    es: 5
  }

  ## Methods

  def update_hash
    status_hash = Time.now.to_i if status_hash.nil?

    update(status_hash: Prime.prime_division(Time.now.to_i*status_hash*rand(status_hash)).last.first)
  end

  # Assign an examiner to the test instance (same language and lowest number of test in the last 7 days)
  # If there are no examiner available, the test instance is still created, but no examiners are assigned to it.
  # The best way I found is to recompute them using whenever every days.
  def assign_examiner
    valid_examiners = User.examiners
                          .can_take_test_instance
                          .where(expert_language: self.language)

    unless valid_examiners.empty?
      self.users << User.user_lower_nb_test(valid_examiners)
    end
  end

  # Assert the existence of a given language
  def self.assert_existence( language )
    ( TestInstance.languages.keys + TestInstance.languages.values ).include?(language)
  end

end
