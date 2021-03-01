require "./test/test_helper"

class TeamManagerTest < Minitest::Test

  def setup
    @data = { games: './data/games.csv',
              teams: './data/teams.csv',
              game_teams: './data/game_teams.csv'
            }
    @team_manager = TeamManager.new(@data)
    @game_manager = GameManager.new(@data[:games])
  end

  def test_it_exists
    assert_instance_of TeamManager, @team_manager
  end

  def test_info_by_id
    assert_equal ({:team_id=>6, :franchise_id=>6, :team_name=>"FC Dallas", :abbreviation=>"DAL", :link=>"/api/v1/teams/6"}),@team_manager.info_by_id(6)
  end

  def test_average_win_percentage
    assert_equal 49.22, @team_manager.average_win_percentage(6)
  end

  def test_all_games_by_season
    assert_instance_of Hash, @team_manager.team_all_games_by_season(1)
  end

  def test_best_season
    assert_equal "20162017", @team_manager.best_season(6)
  end

  def test_worst_season
    assert_equal "20142015", @team_manager.worst_season(6)
  end

  # def test_average_win_percentage
  #
  # end
  #
  # def test_most_goals_scored
  #
  # end
  #
  # def test_fewest_goals_scored
  #
  # end
  #
  # def test_favorite_opponent
  #
  # end
  #
  # def test_rival
  #
  # end

  def test_all_teams_info
    assert_instance_of Hash, @team_manager.all_teams_info
  end

  def test_team_name_by_id
    assert_equal 'Sporting Kansas City', @team_manager.team_name_by_id(5)
    assert_equal 'DC United', @team_manager.team_name_by_id(14)
  end

  def test_seasonal_win_percentage
    array = mock
    array.stubs(:each).returns(@game_manager.games)

    assert_instance_of Float, @team_manager.seasonal_win_percentage(array)
  end
end
