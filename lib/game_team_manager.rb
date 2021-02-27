require_relative 'game_team'
require_relative 'data_loadable'

class GameTeamManager
  include DataLoadable

  attr_reader :game_teams

  def initialize(data)
    @game_teams = load_data(data, GameTeam)
  end
end
