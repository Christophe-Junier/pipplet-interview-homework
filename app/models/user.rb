class User < ApplicationRecord

  # ----------------------------------------
  # USER: Users of the application
  # ----------------------------------------

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

  ## Attributes

  # Role of the user -> default is test_taker (database setup)
  enum role: {
    test_taker: 0,
    admin:      1,
    examiner:   2
  }

  # Spoken and written language of an user, default would be 'en' for internationalization purpose (database setup)
  enum language: {
    en: 0,
    fr: 1
  }

  # ----------------------------------------
  # EXAMINER
  # ----------------------------------------

  ## Scopes
  # scope :valid_for_correction, -> { where( role: 2,
  #                                          status: [0,1] ) }

  ## Attributes

  # Status of an examiner user -> default is pending_validation (database setup)
  enum status: {
    pending_validation: 0,
    validated:          1,
    rejected:           2
  }

  # Expertise language of an examiner user, there is no default language assigned
  # Usually 0 is used for default setting, so it start from 1, doing this, if a default language is later needed, it could be 0
  enum expert_language: {
    en: 1,
    fr: 2,
    de: 3,
    it: 4,
    es: 5
  }

end
