require "rails_helper"

RSpec.describe "Game flow", type: :system do
  before { driven_by :rack_test }

  let!(:song_a) { create(:song) }
  let!(:song_b) { create(:song) }
  let!(:song_c) { create(:song) }
  let!(:song_d) { create(:song) }

  it "lets a player play a round and see the score update" do
    visit root_path

    fill_in "player_name", with: "Ana"
    click_button "Começar"

    round = Game.last.current_round
    correct_song = round.song

    expect(page).to have_selector("button", text: "Tocar trecho")
    expect(page).to have_css("form", count: round.options.size)

    click_button "#{correct_song.artist} - #{correct_song.title}"

    expect(page).to have_content("Pontuação: 10")
  end
end
