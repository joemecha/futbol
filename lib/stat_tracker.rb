require './lib/manager/team_manager'
require './lib/manager/game_team_manager'
require './lib/manager/game_manager'

class StatTracker

  # attr_reader
  # def self.from_csv(locations)
  #   StatTracker.new(locations)
  # end

  def initialize(locations)
    @game_manager = GameManager.new(locations[:games])
    @team_manager = TeamManager.new(locations[:teams])
    @league_stats = LeagueStatistics.new(locations)
  end

  def highest_total_score
    #        game object               tack on total_score
    @game_manager.highest_scoring_game.total_score
  end

  def lowest_total_score
    #        game object               tack on total_score
    @game_manager.lowest_scoring_game.total_score
  end

  def percentage_home_wins
    @game_manager.calculate_percentage_home_wins
  end

  def percentage_visitor_wins
    @game_manager.calculate_percentage_away_wins
  end

  def percentage_ties
    @game_manager.calculate_percentage_ties
  end

  def count_of_games_by_season
    @game_manager.number_of_season_games
  end

  def average_goals_per_game
    @game_manager.average_goals_per_match
  end

  def highest_scoring_home_team
    @team_manager.team_name_by_id(@league_stats.most_home_goals_by_team)
  end

  def lowest_scoring_visitor
    @team_manager.team_name_by_id(@league_stats.least_visitor_goals_by_team)
  end
end
