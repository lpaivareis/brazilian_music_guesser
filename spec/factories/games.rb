FactoryBot.define do
  factory :game do
    sequence(:player_name) { |n| "Player #{n}" }
    status { "in_progress" }
    genres { [] }
  end
end
