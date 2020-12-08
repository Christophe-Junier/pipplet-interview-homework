# frozen_string_literal: true

FactoryBot.define do
  factory :test_instance do
    status_hash { nil }

    trait(:en) { language { 1 } }
    trait(:fr) { language { 2 } }
    trait(:de) { language { 3 } }
    trait(:it) { language { 4 } }
    trait(:es) { language { 5 } }
  end
end
