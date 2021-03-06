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

  def greatest_season(team_id)
    seasons = team_all_games_by_season(team_id)
    winning_percents_by_season = seasons.transform_values do |season_games|
      seasonal_win_percentage(season_games)
    end
    winning_percents_by_season.key(winning_percents_by_season.values.max).to_s
  end

  def most_terrible_season(team_id)
    seasons = team_all_games_by_season(team_id)
    winning_percents_by_season = seasons.transform_values do |season_games|
      seasonal_win_percentage(season_games)
    end
    winning_percents_by_season.key(winning_percents_by_season.values.min).to_s
  end

  def mean_win_percentage(team_id)
    wins = @game_teams.find_all do |game|
      game.team_id == team_id && game.result == "WIN"
    end.count
    all = @game_teams.find_all do |game|
      game.team_id == team_id
    end.count
    ((wins.to_f / all) * 100).round(2)
  end

  def highest_goals_scored(team_id)
    matching_team = @game_teams.select do |game|
      game.team_id == team_id
    end
    matching_team.map do |game|
      game.goals
    end.max
  end

  def least_goals_scored(team_id)
    matching_team = @game_teams.select do |game|
      game.team_id == team_id
    end
    matching_team.map do |game|
      game.goals
    end.min
  end

  def easiest_opponent(team_id)
    games_by_id = @game_manager.games.select do |game|
      (game.home_team_id == team_id || game.away_team_id == team_id)
    end
    losing_teams = []
    games_by_id.each do |game|
      if game.home_team_id == team_id && game.winner == :home
        losing_teams << game.away_team_id
      elsif game.away_team_id == team_id && game.winner == :visitor
        losing_teams << game.home_team_id
      end
    end
    loser_id = losing_teams.max_by {|id| losing_teams.count(id)}
    team_name_by_id(loser_id)
  end

  def toughest_opponent(team_id)
    games_by_id = @game_manager.games.select do |game|
      (game.home_team_id == team_id || game.away_team_id == team_id)

    end
    winning_teams = []
    games_by_id.each do |game|
      if game.home_team_id != team_id && game.winner == :home
        winning_teams << game.home_team_id
      elsif game.away_team_id != team_id && game.winner == :visitor
        winning_teams << game.away_team_id
      end
    end
    tough_id = winning_teams.max_by {|id| winning_teams.count(id)}
    team_name_by_id(tough_id)
  end


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

  def team_all_games_by_season(team_id)
    @game_manager.games_by_season.transform_values! do |array|
      array.find_all do |game|
        game.home_team_id == team_id || game.away_team_id == team_id
      end
    end
  end

  def seasonal_win_percentage(array)
    total_games = 0
    wins = 0
    array.each do |game|
      total_games += 1
      @game_teams.each do |game_team|
        wins += 1 if game_team.game_id == game.game_id && game_team.result == "WIN"
      end
    end
    ((wins.to_f / total_games) * 100).round(2)
  end

  def number_of_teams
    @teams.count
  end
end
