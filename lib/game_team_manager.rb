require_relative 'game_team'
require_relative 'data_loadable'

class GameTeamManager
  include DataLoadable

  attr_reader :game_teams

  def initialize(data)
    @game_teams = load_data(data, GameTeam)
  end

# DID NOT WORK !!!
# Season Statistics ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # def retained_coach(season_id)
  #   current_season = seasons_and_games(season_id)
  #
  #   wins_by_coach = correct_array(current_season).each_with_object(Hash.new { |hash, key| hash[key] =  {wins: 0, total: 0}}) do |game_team, wins|
  #     wins[game_team.head_coach][:total] += 1
  #     wins[game_team.head_coach][:wins] += 1 if game_team.result == "WIN"
  #   end
  #
  #   wins_by_coach.transform_values! do |results|
  #     ((results[:wins].to_f / results[:total]) * 100).round(2)
  #   end.key(wins_by_coach.values.max)
  # end
  #
  # def fired_coach(season_id)
  #   current_season = seasons_and_games(season_id)
  #
  #   losses_by_coach = correct_array(current_season).each_with_object(Hash.new { |hash, key| hash[key] =  {losses: 0, total: 0}}) do |game_team, losses|
  #     losses[game_team.head_coach][:total] += 1
  #     losses[game_team.head_coach][:losses] += 1 if game_team.result == "LOSS"
  #   end
  #
  #   losses_by_coach.transform_values! do |results|
  #     ((results[:losses].to_f / results[:total]) * 100).round(2)
  #   end.key(losses_by_coach.values.max)
  # end
  #
  # def best_shot_ratio(season_id)
  #   current_season = seasons_and_games(season_id)
  #
  #   shots_and_goals = correct_array(current_season).each_with_object(Hash.new { |hash, key| hash[key] =  {goals: 0, shots: 0}}) do |game_team, goals|
  #     goals[game_team.team_id][:goals] += game_team.goals
  #     goals[game_team.team_id][:shots] += game_team.shots
  #   end
  #
  #   shots_and_goals.transform_values! do |results|
  #     (results[:goals].to_f / results[:shots]).round(4)
  #   end.key(shots_and_goals.values.max)
  # end
  #
  # def worst_shot_ratio(season_id)
  #   current_season = seasons_and_games(season_id)
  #
  #   shots_and_goals = correct_array(current_season).each_with_object(Hash.new { |hash, key| hash[key] =  {goals: 0, shots: 0}}) do |game_team, goals|
  #     goals[game_team.team_id][:goals] += game_team.goals
  #     goals[game_team.team_id][:shots] += game_team.shots
  #   end
  #   shots_and_goals.transform_values! do |results|
  #     (results[:goals].to_f / results[:shots]).round(4)
  #   end.key(shots_and_goals.values.min)
  # end
  #
  # def most_tickles(season_id)
  #   current_season = seasons_and_games(season_id)
  #
  #   tack = correct_array(current_season).each_with_object(Hash.new { |hash, key| hash[key] = 0}) do |game_team, tackles|
  #     tackles[game_team.team_id] += game_team.tackles
  #   end
  #
  #   tack.key(tack.values.max)
  # end
  #
  # def fewest_tickles(season_id)
  #   current_season = seasons_and_games(season_id)
  #
  #   tack = correct_array(current_season).each_with_object(Hash.new { |hash, key| hash[key] = 0}) do |game_team, tackles|
  #     tackles[game_team.team_id] += game_team.tackles
  #   end
  #
  #   tack.key(tack.values.min)
  # end
  #
  # def seasons_and_games(season_id)
  #   @game_manager.games_by_season[season_id]
  # end
  #
  # def correct_array(current_season)
  #   season_games = []
  #   @game_teams.each do |game_team|
  #     id = game_team.game_id
  #     current_season.each do |game|
  #       season_games << game_team if game.game_id == id
  #     end
  #   end
  #   season_games
  # end
end
