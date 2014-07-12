# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :appointment do
    sequence(:title){|i| "Birthday#{i}"}
    description "My Party"
    location "My House"
    date "07/01/2014"
    time "5:00pm"
  end
end