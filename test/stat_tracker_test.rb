require "./test/test_helper"

class StatTrackerTest < Minitest::Test

  def setup
    @games = './data/games.csv'
    @game_teams = './data/game_teams.csv'
    @teams = './data/teams.csv'
    @locations = {
      games: @games,
      game_teams: @game_teams,
      teams: @teams
    }
    @tracker = StatTracker.new(@locations)
  end

  def test_it_exists
    # require "pry";binding.pry
    assert_instance_of StatTracker, @tracker
  end

  # def test_load_data
  #   # require "pry";binding.pry
  #   assert_equal [], @tracker.load_data(@games, GameManager)
  #   assert_equal [], @tracker.load_data(@game_teams, GameTeamManager)
  #   assert_equal [], @tracker.load_data(@teams, TeamManager)
  # end

  # def test_it_has_attributes
  #   self.from_csv(@locations)
  # end

  def test_name_of_highest_scoring_home_team
    assert_equal 'Reign FC', @tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal 'San Jose Earthquakes', @tracker.lowest_scoring_visitor
  end
end
