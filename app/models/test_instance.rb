require 'prime'

class TestInstance < ApplicationRecord

  def update_hash
    status_hash = Time.now.to_i if status_hash.nil?

    update(status_hash: Prime.prime_division(Time.now.to_i*status_hash*rand(status_hash)).last.first)
  end

end
