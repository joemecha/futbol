class LeagueStatistics
  include DataLoadable

  def initialize(data)
    @game_manager = GameManager.new(data[:games])
    @teams = load_data(data[:teams], Team)
    @game_teams = load_data(data[:game_teams], GameTeam)
  end

  def count_of_teams
    @teams.count
    # Description - Total number of teams in the data.
    # Return Value - Integer
  end

  def best_offense
    # Description - Name of the team with the highest average number of goals scored per game across all seasons.
    # Return Value - String
  end

  def worst_offense
    # Description - Name of the team with the lowest average number of goals scored per game across all seasons.
    # Return Value - String
  end

  def highest_scoring_visitor
    # Description - Name of the team with the highest average score per game across all seasons when they are away.
    # Return Value - String
  end

  def most_home_goals_by_team
    games_by_team = @game_manager.games.reduce({}) do |hash, game|
      hash[game.home_team_id] << game if hash[game.home_team_id]
      hash[game.home_team_id] = [game] if hash[game.home_team_id].nil?
      hash
    end
    average_goals_by_team = games_by_team.transform_values! do |array|
      total_goals = array.map do |game|
        game.home_goals
      end.sum
      (total_goals.to_f / array.count).round(2)
    end
    average_goals_by_team.key(average_goals_by_team.values.max)
  end

  def least_visitor_goals_by_team
    games_by_team = @game_manager.games.reduce({}) do |hash, game|
      hash[game.away_team_id] << game if hash[game.away_team_id]
      hash[game.away_team_id] = [game] if hash[game.away_team_id].nil?
      hash
    end
    average_goals_by_team = games_by_team.transform_values! do |array|
      total_goals = array.map do |game|
        game.away_goals
      end.sum
      (total_goals.to_f / array.count).round(2)
    end
    average_goals_by_team.key(average_goals_by_team.values.min)
  end

  def lowest_scoring_home_team
    # Description - Name of the team with the lowest average score per game across all seasons when they are at home.
    # Return Value - String
  end
end
