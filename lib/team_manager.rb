require_relative "team"
require_relative 'data_loadable'

class TeamManager
  include DataLoadable

  attr_reader :teams

  def initialize(data)
    @teams = load_data(data, Team)
    @game_teams = load_data(data, GameTeam)
    @games = load_data(data, Game)
  end

  def info_by_id(team_id)
    all_teams_info[team_id]
  end

  def best_season

    # Description: Season with the highest win percentage for a team.
    # Return Value: String
  end

#   def worst_season
#     # Description: Season with the lowest win percentage for a team.
#     # Return Value: String
#   end
#
#   def average_win_percentage
#     # Description: Average win percentage of all games for a team.
#     # Return Value: Float
#   end
#
#   def most_goals_scored
#     # Description: Highest number of goals a particular team has scored
#     #              in a single game.
#     # Return Value: Integer
#   end
#
#   def fewest_goals_scored
#     # Description: Lowest numer of goals a particular team has scored
#     #              in a single game.
#     # Return Value: Integer
#   end
#
#   def favorite_opponent
#     # Description: Name of the opponent that has the lowest win percentage
#     #              against the given team.
#     # Return Value: String
#   end
#
#   def rival
#     # Description: Name of the opponent that has the highest win percentage
#     #              against the given team.
#     # Return Value: String
#   end

def all_teams_info
  @teams.each_with_object(Hash.new { |hash, key| hash[key] =  0}) do |team, ids|
    ids[team.team_id] = team.team_info
  end
end

  def team_name_by_id(desired_id)
    matching_id = @teams.find do |team|
      team.team_id == desired_id
    end
    matching_id.team_name
  end
end
