require_relative 'game'
require_relative 'data_loadable'
require_relative 'mathable'

class GameManager
  include DataLoadable
  include Mathable

  attr_reader :games

  def initialize(data)
    @games = load_data(data, Game)
  end

  def highest_scoring_game
    @games.max_by do |game|
      game.total_score
    end
  end

  def lowest_scoring_game
    @games.min_by do |game|
      game.total_score
    end
  end

  def home_wins
    @games.find_all do |game|
      game.winner == :home
    end.count
  end

  def away_wins
    @games.find_all do |game|
      game.winner == :away
    end.count
  end

  def ties
    @games.find_all do |game|
      game.winner == :tie
    end.count
  end

  def calculate_percentage_home_wins
    percent(home_wins, games.count)
  end

  def calculate_percentage_away_wins
    percent(away_wins, games.count)
  end

    def calculate_percentage_ties
    percent(ties, games.count)
  end

  def number_of_season_games
    season_names_and_games = {}
    @games.each do |game|
      if season_names_and_games[game.season].nil?
         season_names_and_games[game.season] = 1
      else
         season_names_and_games[game.season] += 1
      end
    end
    season_names_and_games
  end

  def average_goals_per_match
    all_goals = 0
    @games.each do |game|
      all_goals += game.total_score
    end
    ratio(all_goals, games.count)
  end

  def average_scores_by_season
    games_by_season.transform_values! do |array|
      avg = array.map do |game|
        game.total_score
      end.sum
      ratio(avg, array.length)
    end
  end

  def games_by_season
    season_games = @games.reduce({}) do |hash, game|
      hash[game.season] << game if hash[game.season]
      hash[game.season] = [game] if hash[game.season].nil?
      hash
    end
    season_games
  end

  # League Statistics ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def best_attackers
    home_team_hash = {}
    @games.each do |game|
      if home_team_hash[game.home_team_id].nil?
        home_team_hash[game.home_team_id] = game.home_goals
      else
        home_team_hash[game.home_team_id] += game.home_goals
      end
    end

    away_team_hash = {}
    @games.each do |game|
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
    @games.each do |game|
      team_id_appearances << game.home_team_id
      team_id_appearances << game.away_team_id
    end

    team_total_games = {}
    team_id_appearances.each do |team_id|
      team_total_games[team_id] = team_id_appearances.count(team_id)
    end

    # divide values by number of games for average
    j = ids_and_total_goals.merge!(team_total_games) do |team_id, total_goals, total_games|
      ratio(total_goals, total_games)
    end

    # last, find max
    j.key(j.values.max)
  end

  def worst_attackers
    home_team_hash = {}
    @games.each do |game|
      if home_team_hash[game.home_team_id].nil?
        home_team_hash[game.home_team_id] = game.home_goals
      else
        home_team_hash[game.home_team_id] += game.home_goals
      end
    end

    away_team_hash = {}
    @games.each do |game|
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
    @games.each do |game|
      team_id_appearances << game.home_team_id
      team_id_appearances << game.away_team_id
    end

    team_total_games = {}
    team_id_appearances.each do |team_id|
      team_total_games[team_id] = team_id_appearances.count(team_id)
    end

    # divide values by number of games for average
    j = ids_and_total_goals.merge!(team_total_games) do |team_id, total_goals, total_games|
      ratio(total_goals, total_games)
    end

    # last, find min
    j.key(j.values.min)
  end

  def most_goals_by_away_team
    games_by_team = @games.reduce({}) do |hash, game|
      hash[game.away_team_id] << game if hash[game.away_team_id]
      hash[game.away_team_id] = [game] if hash[game.away_team_id].nil?
      hash
    end
    average_goals_by_team = games_by_team.transform_values! do |array|
      total_goals = array.map do |game|
        game.away_goals
      end.sum
      ratio(total_goals, array.count)
    end
    average_goals_by_team.key(average_goals_by_team.values.max)
  end

  def most_home_goals_by_team
    games_by_team = @games.reduce({}) do |hash, game|
      hash[game.home_team_id] << game if hash[game.home_team_id]
      hash[game.home_team_id] = [game] if hash[game.home_team_id].nil?
      hash
    end
    average_goals_by_team = games_by_team.transform_values! do |array|
      total_goals = array.map do |game|
        game.home_goals
      end.sum
      ratio(total_goals, array.count)
    end
    average_goals_by_team.key(average_goals_by_team.values.max)
  end

  def least_visitor_goals_by_team
    games_by_team = games.reduce({}) do |hash, game|
      hash[game.away_team_id] << game if hash[game.away_team_id]
      hash[game.away_team_id] = [game] if hash[game.away_team_id].nil?
      hash
    end
    average_goals_by_team = games_by_team.transform_values! do |array|
      total_goals = array.map do |game|
        game.away_goals
      end.sum
      ratio(total_goals, array.count)
    end
    average_goals_by_team.key(average_goals_by_team.values.min)
  end

  def least_home_goals_by_team
    games_by_team = games.reduce({}) do |hash, game|
      hash[game.home_team_id] << game if hash[game.home_team_id]
      hash[game.home_team_id] = [game] if hash[game.home_team_id].nil?
      hash
    end
    average_goals_by_team = games_by_team.transform_values! do |array|
      total_goals = array.map do |game|
        game.home_goals
      end.sum
      ratio(total_goals, array.count)
    end
    average_goals_by_team.key(average_goals_by_team.values.min)
  end
end
