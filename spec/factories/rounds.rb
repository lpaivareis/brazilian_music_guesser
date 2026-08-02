FactoryBot.define do
  factory :round do
    game
    song

    option_song_ids { [ song.id ] }
  end
end
