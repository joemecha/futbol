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
    assert_instance_of StatTracker, @tracker
  end

  def test_highest_total_score
    assert_equal 11, @tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 0, @tracker.lowest_total_score
  end
# ===== Ask about testing bc tested w/ stubs in game_manager file ====
  # def test_percentage_home_wins
  #   assert_equal , @tracker.test_percentage_home_wins
  # end
  #
  # def test_percentage_visitor_wins
  #   assert_equal , @tracker.percentage_visitor_wins
  # end
  #
  # def test_percentage_ties
  #   assert_equal , @tracker.percentage_ties
  # end
# ==================================================================
  def test_count_of_games_by_season
    expected = {20122013=>806, 20162017=>1317, 20142015=>1319, 20152016=>1321, 20132014=>1323, 20172018=>1355}

    assert_equal expected, @tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.22, @tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {20122013=>4.12, 20162017=>4.23, 20142015=>4.14, 20152016=>4.16, 20132014=>4.19, 20172018=>4.44}

    assert_equal expected, @tracker.average_goals_by_season
  end

  def test_count_of_teams
    assert_equal 32, @tracker.count_of_teams
  end

  def test_best_offense
    assert_equal 'Reign FC', @tracker.best_offense
  end

  def test_worst_offense
    assert_equal 'Utah Royals FC', @tracker.worst_offense
  end

  def test_name_of_highest_scoring_visitor
    assert_equal 'FC Dallas', @tracker.highest_scoring_visitor
  end

  def test_name_of_highest_scoring_home_team
    assert_equal 'Reign FC', @tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal 'San Jose Earthquakes', @tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal 'Utah Royals FC', @tracker.lowest_scoring_home_team
  end

  def test_winningest_coach
    assert_equal "Dan Lacroix", @tracker.winningest_coach(20122013)
  end

  def test_worst_coach
    assert_equal "Martin Raymond", @tracker.worst_coach(20122013)
  end

  def test_most_accurate_team
    assert_equal "DC United", @tracker.most_accurate_team(20122013)
  end

  def test_least_accurate_team
    assert_equal "New York City FC", @tracker.least_accurate_team(20122013)
  end

  def test_most_tackles
    assert_equal "FC Cincinnati", @tracker.most_tackles(20122013)
  end

  def test_fewest_tackles
    assert_equal "Atlanta United", @tracker.fewest_tackles(20122013)
  end

  def test_team_info
    assert_equal ({:team_id=>6, :franchise_id=>6, :team_name=>"FC Dallas", :abbreviation=>"DAL", :link=>"/api/v1/teams/6"}), @tracker.team_info(6)
  end

  def test_best_season
    assert_equal "20162017", @tracker.best_season(6)
  end

  def test_worst_season
    assert_equal "20142015", @tracker.worst_season(6)
  end

  def test_average_win_percentage
    assert_equal 49.22, @tracker.average_win_percentage(6)
  end

  def test_most_goals_scored
    assert_equal 6, @tracker.most_goals_scored(14)
  end

  def test_fewest_goals_scored
    assert_equal 0, @tracker.fewest_goals_scored(6)
  end

  def test_favorite_opponent
    assert_equal "North Carolina Courage", @tracker.favorite_opponent(7)
  end

  def test_rival
    assert_equal "Los Angeles FC", @tracker.rival(26)
  end
end
