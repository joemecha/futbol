require "./test/test_helper"
require 'mocha/Minitest'

class GameManagerTest < Minitest::Test
  def setup
    @game_data = './data/games_to_test.csv'

    @game_manager = GameManager.new(@game_data)
  end

  def test_it_exists
    assert_instance_of GameManager, @game_manager
  end

  def test_highest_and_lowest_scoring_game
    assert_equal 9, @game_manager.highest_scoring_game.total_score
    assert_equal 1, @game_manager.lowest_scoring_game.total_score
  end

  def test_home_wins
    assert_equal 24, @game_manager.home_wins
  end

  def test_away_wins
    assert_equal 0, @game_manager.away_wins
  end

  def test_ties
    assert_equal 13, @game_manager.ties
  end

  def test_calculate_percentage_home_wins
    @game_manager.stubs(:home_wins).returns(2)
    @game_manager.stubs(:games).returns([1, 2, 3])

    assert_equal 66.67, @game_manager.calculate_percentage_home_wins
  end

  def test_calculate_percentage_away_wins
    @game_manager.stubs(:away_wins).returns(2)
    @game_manager.stubs(:games).returns([1, 2, 3])

    assert_equal 66.67, @game_manager.calculate_percentage_away_wins
  end

  def test_calculate_percentage_ties
    @game_manager.stubs(:ties).returns(2)
    @game_manager.stubs(:games).returns([1, 2, 3])

    assert_equal 66.67, @game_manager.calculate_percentage_ties
  end

  def test_number_of_season_games
    expected = {20122013=>10, 20132014=>26, 20162017=>10, 20172018=>12, 20152016=>5}

    assert_equal expected, @game_manager.number_of_season_games
  end

  def test_average_goals_per_match
    assert_equal 4.21, @game_manager.average_goals_per_match
  end

  def test_average_scores_by_season
    expected = {20122013=>3.8, 20132014=>4.27, 20162017=>3.8, 20172018=>4.75, 20152016=>4.2}

    assert_equal expected, @game_manager.average_scores_by_season
  end

  def test_games_by_season
    @game_manager.games_by_season
    assert_equal 20122013, @game_manager.games_by_season.keys.first
  end

  # League Statistics Tests ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  def test_best_attackers
    assert_equal 27, @game_manager.best_attackers
  end

  def test_worst_attackers
    assert_equal 16, @game_manager.worst_attackers
  end

  def test_most_goals_by_away_team
    assert_equal 28, @game_manager.most_goals_by_away_team
  end

  def test_most_home_goals_by_team
    assert_equal 27, @game_manager.most_home_goals_by_team
  end

  def test_least_visitor_goals_by_team
    assert_equal 20, @game_manager.least_visitor_goals_by_team
  end

  def test_least_home_goals_by_team
    assert_equal 2, @game_manager.least_home_goals_by_team
  end
end
