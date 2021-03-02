require "./test/test_helper"

class TeamManagerTest < Minitest::Test

  def setup
    @data = { games: './data/games.csv',
              teams: './data/teams.csv',
              game_teams: './data/game_teams.csv'
            }
    @team_manager = TeamManager.new(@data)

    @game_manager = GameManager.new(@data[:game_teams])
  end

  def test_it_exists
    assert_instance_of TeamManager, @team_manager
  end

  def test_info_by_id
    assert_equal ({:team_id=>6, :franchise_id=>6, :team_name=>"FC Dallas", :abbreviation=>"DAL", :link=>"/api/v1/teams/6"}),@team_manager.info_by_id(6)
  end

  def test_most_goals_scored
    assert_equal 6, @team_manager.most_goals_scored(14)
  end

  def test_fewest_goals_scored
    assert_equal 0, @team_manager.fewest_goals_scored(6)
  end
  #
  # def test_team_game_info
  #   assert_equal 0, @team_manager.team_game_info
  # end
  # def test_team_info
  #
  # end
  #
  # def test_best_season
  #
  # end
  #
  # def test_worst_season
  #
  # end
  #
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
end
