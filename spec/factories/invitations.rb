# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    sequence(:invite_email){|i| "test#{i}@test.com"}
    user_id "3"
  end
end

