require 'rails_helper'

describe 'it can get a single game' do
  before(:each) do
    josh = User.create(id: 1, name: "Josh")
    sal = User.create(id: 2, name: "Sal")

    game = Game.create(player_1: josh, player_2: sal)

    josh.plays.create(game: game, word: "sal", score: 3)
    josh.plays.create(game: game, word: "zoo", score: 12)
    sal.plays.create(game: game, word: "josh", score: 14)
    sal.plays.create(game: game, word: "no", score: 2)
  end
  it 'returns a json response' do
    # Background: This story assumes the base data from running `rake db:seed`
    # When I send a GET request to "/api/v1/games/1" I receive a JSON response as follows:

    get '/api/v1/games/1'
    # {
    #   "game_id":1,
    #   "scores": [
    #     {
    #       "user_id":1,
    #       "score":15
    #     },
    #     {
    #       "user_id":2,
    #       "score":16
    #     }
    #   ]
    # }
    expect(response).to be_successful
    binding.pry
    game = JSON.parse(response.body)

    expect(game['game_id']).to eq(1)
    expect(game['scores'][0]['user_id']).to eq(1)
    expect(game['scores'][0]['score']).to eq(15)
    expect(game['scores'][1]['user_id']).to eq(1)
    expect(game['scores'][1]['score']).to eq(15)
  end
end
