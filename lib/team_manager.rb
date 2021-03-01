require_relative "team"
require_relative 'data_loadable'

class TeamManager
  include DataLoadable

  attr_reader :teams

  def initialize(data)
    @game_manager = GameManager.new(data[:games])
    @teams = load_data(data[:teams], Team)
    @game_teams = load_data(data[:game_teams], GameTeam)
  end

  def info_by_id(team_id)
    all_teams_info[team_id]
  end

  def best_season(team_id)
    seasons = team_all_games_by_season(team_id)
    winning_percents_by_season = seasons.transform_values do |season|
      winning_percentage(team_id) # build identical helper method that takes an array as arg
    end
    require "pry"; binding.pry




    # t = seasons.transform_values do |array|
    #   array.each_with_object(Hash.new { |hash, key| hash[key] = {wins: 0, games: 0}}) do |game, wins|
    #
    #     wins[game.season][:games] += 1
    #     all_winning_games(team_id).each do |game_team|
    #       wins[game.season][:wins] += 1 if game.game_id == game_team.game_id
    #     end
    #   end
    # end


    # season key => [all games in a season]

  end

def team_all_games_by_season(team_id)
  @game_manager.games_by_season.transform_values! do |array|
    array.find_all do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
  end
end


#   def worst_season
#     # Description: Season with the lowest win percentage for a team.
#     # Return Value: String
#   end
#

def average_win_percentage(team_id)
  wins = @game_teams.find_all do |game|
    game.team_id == team_id && game.result == "WIN"
  end.count
  all = @game_teams.find_all do |game|
    game.team_id == team_id
  end.count
  ((wins.to_f / all) * 100).round(2)
end

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
