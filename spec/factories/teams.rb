FactoryGirl.define do
  factory :team do
    sequence(:name) { |i| "Team #{i}" }
    leader
  end
end
