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

  def best_season
    # @games.each_with_object(Hash.new { |hash, key| hash[key] =  0}) do |game, ids|
    #   ids[game.game_id] = game.type
    # Description: Season with the highest win percentage for a team.
    # Return Value: String
  end

  def games_to_team_game_hash
    @games.group_by do |game_id|
      game_id
	  end
  end

  def most_goals_scored(team_id)
    matching_team = @game_teams.select do |game|
      game.team_id == team_id
    end
    matching_team.map do |game|
      game.goals
    end.max
  end

  def fewest_goals_scored(team_id)
    matching_team = @game_teams.select do |game|
      game.team_id == team_id
    end
    matching_team.map do |game|
      game.goals
    end.min
  end
  # def team_game_info
  #   games_to_team_game_hash = { game_id: [season] [type] [date_time] [away_team_id] [home_team_id] [away_goals] [home_goals] [venue] [venue_link] }
  #   require "pry"; binding.pry
  # end
# To call on values = team_game_info[:game_id][index] => value at index

  # def most_goals_scored(team_id)
  #   t = []
  #   @games.each do |game|
  #     if game.home_goals > game.away_goals
  #       t << game.home_team_id
  #     elsif game.home_goals == game.away_goals
  #       t
  #     end
  #   end
  #   beans = t[0]
  # end
  #
  # def fewest_goals_scored(team_id)
  #   t = []
  #   @games.each do |game|
  #     if game.home_goals < game.away_goals
  #       t << game.home_team_id
  #     elsif game.home_goals == game.away_goals
  #       t
  #     end
  #   end
  #   beans = t[0]
  # end


  # def most_goals_scored(team_id)
  #   @games.max_by do |game|
  #   end
  #   #
  # end

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
