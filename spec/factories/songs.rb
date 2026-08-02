FactoryBot.define do
  factory :song do
    sequence(:artist) { |n| "Artist #{n}" }
    sequence(:title) { |n| "Title #{n}" }
    sequence(:youtube_id) { |n| "yt_video_#{n}"[0, 11] }
    clip_start { 30 }
    clip_end { 45 }
  end
end
