class Game < ApplicationRecord
  belongs_to :player_1, class_name: "User", foreign_key: :player_1_id
  belongs_to :player_2, class_name: "User", foreign_key: :player_2_id

  has_many :plays

  def total_score(id)
    user = User.find(id)
    user.plays.map do |play|
      play.score
    end.sum
  end

  def as_json
    {
      game_id: id,
      scores: [{ user_id: player_1_id, score: total_score(player_1_id)},
               { user_id: player_2_id, score: total_score(player_2_id)}]
    }
  end
end
