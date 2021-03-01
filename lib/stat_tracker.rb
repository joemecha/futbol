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
    @team_manager = TeamManager.new(locations[:teams])
    @league_stats = LeagueStatistics.new(locations)
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
#=====================================
  def count_of_teams
    @league_stats.number_of_teams
  end

  def best_offense
    @team_manager.team_name_by_id(@league_stats.best_attackers)
  end

  def worst_offense
    @team_manager.team_name_by_id(@league_stats.worst_attackers)
  end

  def highest_scoring_visitor
    @team_manager.team_name_by_id(@league_stats.most_goals_by_away_team)
  end

  def highest_scoring_home_team
    @team_manager.team_name_by_id(@league_stats.most_home_goals_by_team)
  end

  def lowest_scoring_visitor
    @team_manager.team_name_by_id(@league_stats.least_visitor_goals_by_team)
  end

  def lowest_scoring_home_team
    @team_manager.team_name_by_id(@league_stats.least_home_goals_by_team)
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
end
