require_relative 'team_manager'
require_relative 'game_team_manager'
require_relative 'game_manager'

class StatTracker
# required by rspec, still doesn't work b/c of module
  # def self.from_csv(locations)
  #   StatTracker.new(locations)
  # end

  def initialize(locations)
    @game_manager = GameManager.new(locations[:games])
    @team_manager = TeamManager.new(locations)
    # @league_stats = LeagueStatistics.new(locations)
    @season_stats = SeasonStatistics.new(locations)
  end

  def highest_total_score
    @game_manager.highest_scoring_game.total_score
  end

  def lowest_total_score
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

  def average_goals_by_season
    @game_manager.average_scores_by_season
  end

  def count_of_teams
    @team_manager.number_of_teams
  end

  def best_offense
    @team_manager.team_name_by_id(@game_manager.best_attackers)
  end

  def worst_offense
    @team_manager.team_name_by_id(@game_manager.worst_attackers)
  end

  def highest_scoring_visitor
    @team_manager.team_name_by_id(@game_manager.most_goals_by_away_team)
  end

  def highest_scoring_home_team
    @team_manager.team_name_by_id(@game_manager.most_home_goals_by_team)
  end

  def lowest_scoring_visitor
    @team_manager.team_name_by_id(@game_manager.least_visitor_goals_by_team)
  end

  def lowest_scoring_home_team
    @team_manager.team_name_by_id(@game_manager.least_home_goals_by_team)
  end

  def winningest_coach(season_id)
    @season_stats.retained_coach(season_id)
  end

  def worst_coach(season_id)
    @season_stats.fired_coach(season_id)
  end

  def most_accurate_team(season_id)
    @team_manager.team_name_by_id(@season_stats.best_shot_ratio(season_id))
  end

  def least_accurate_team(season_id)
    @team_manager.team_name_by_id(@season_stats.worst_shot_ratio(season_id))
  end

  def most_tackles(season_id)
    @team_manager.team_name_by_id(@season_stats.most_tickles(season_id))
  end

  def fewest_tackles(season_id)
    @team_manager.team_name_by_id(@season_stats.fewest_tickles(season_id))
  end

  def team_info(team_id)
    @team_manager.info_by_id(team_id)
  end

  def best_season(team_id)
    @team_manager.greatest_season(team_id)
  end

  def worst_season(team_id)
    @team_manager.most_terrible_season(team_id)
  end

  def average_win_percentage(team_id)
    @team_manager.mean_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @team_manager.highest_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @team_manager.least_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @team_manager.easiest_opponent(team_id)
  end

  def rival(team_id)
    @team_manager.toughest_opponent(team_id)
  end
end
