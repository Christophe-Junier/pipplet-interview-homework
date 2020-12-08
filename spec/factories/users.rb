# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name                { 'Awesome name' }
    email               { 'AwesomeEmail@gmail.com' }
    language            { 0 }
    test_instance_count { 0 }

    trait(:admin)      { role { 1 } }
    trait(:test_taker) { role { 0 } }
    trait(:examiner)   { role { 2 } }
    trait(:examiner_rejected)  { status { 2 } }
    trait(:examiner_validated) { status { 1 } }
    trait(:examiner_pending)   { status { 0 } }
    trait(:examiner_en) { expert_language { 1 } }
    trait(:examiner_fr) { expert_language { 2 } }
    trait(:examiner_de) { expert_language { 3 } }
    trait(:examiner_it) { expert_language { 4 } }
    trait(:examiner_es) { expert_language { 5 } }
  end
end
