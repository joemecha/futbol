class LeagueStatistics
  include DataLoadable

  def initialize(data)
    @game_manager = GameManager.new(data[:games])
    @teams = load_data(data[:teams], Team)
    @game_teams = load_data(data[:game_teams], GameTeam)
  end

  def number_of_teams
    @teams.count
  end

  def best_attackers
    home_team_hash = {}
    @game_manager.games.each do |game|
      if home_team_hash[game.home_team_id].nil?
        home_team_hash[game.home_team_id] = game.home_goals
      else
        home_team_hash[game.home_team_id] += game.home_goals
      end
    end

    away_team_hash = {}
    @game_manager.games.each do |game|
      if away_team_hash[game.away_team_id].nil?
        away_team_hash[game.away_team_id] = game.away_goals
      else
        away_team_hash[game.away_team_id] += game.away_goals
      end
    end

    # Hash of team_id keys and total_goals values
    ids_and_total_goals = home_team_hash.merge!(away_team_hash) do |team, home_goals, away_goals|
      home_goals + away_goals
    end


    # Total number of games by team
    team_id_appearances = [ ]
    @game_manager.games.each do |game|
      team_id_appearances << game.home_team_id
      team_id_appearances << game.away_team_id
    end

    team_total_games = {}
    team_id_appearances.each do |team_id|
      team_total_games[team_id] = team_id_appearances.count(team_id)
    end

    # divide values by number of games for average
    j = ids_and_total_goals.merge!(team_total_games) do |team_id, total_goals, total_games|
      (total_goals.to_f / total_games).round(2)
    end

    # last, find max
    j.key(j.values.max)
  end

  def worst_attackers 
    home_team_hash = {}
    @game_manager.games.each do |game|
      if home_team_hash[game.home_team_id].nil?
        home_team_hash[game.home_team_id] = game.home_goals
      else
        home_team_hash[game.home_team_id] += game.home_goals
      end
    end

    away_team_hash = {}
    @game_manager.games.each do |game|
      if away_team_hash[game.away_team_id].nil?
        away_team_hash[game.away_team_id] = game.away_goals
      else
        away_team_hash[game.away_team_id] += game.away_goals
      end
    end

    # Hash of team_id keys and total_goals values
    ids_and_total_goals = home_team_hash.merge!(away_team_hash) do |team, home_goals, away_goals|
      home_goals + away_goals
    end


    # Total number of games by team
    team_id_appearances = [ ]
    @game_manager.games.each do |game|
      team_id_appearances << game.home_team_id
      team_id_appearances << game.away_team_id
    end

    team_total_games = {}
    team_id_appearances.each do |team_id|
      team_total_games[team_id] = team_id_appearances.count(team_id)
    end

    # divide values by number of games for average
    j = ids_and_total_goals.merge!(team_total_games) do |team_id, total_goals, total_games|
      (total_goals.to_f / total_games).round(2)
    end

    # last, find min
    j.key(j.values.min)
  end

  def most_goals_by_away_team
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
    average_goals_by_team.key(average_goals_by_team.values.max)
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

  def least_home_goals_by_team
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
    average_goals_by_team.key(average_goals_by_team.values.min)
  end
end
