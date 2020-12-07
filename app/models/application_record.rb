# frozen_string_literal: true

# Base model that will be inerited by all our model
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
