require "./test/test_helper"

class SeasonStatisticsTest < Minitest::Test
  def setup
    @data = { games: './data/games.csv',
              teams: './data/teams.csv',
              game_teams: './data/game_teams.csv'
            }
    @season_stats = SeasonStatistics.new(@data)
  end

  def test_it_exists
    assert_instance_of SeasonStatistics, @season_stats
  end

  def test_retained_coach
    assert_equal "Dan Lacroix", @season_stats.retained_coach(20122013)
    assert_equal "Bruce Cassidy", @season_stats.retained_coach(20172018)
  end

  def test_fired_coach
    assert_equal "Martin Raymond", @season_stats.fired_coach(20122013)
    assert_equal "Phil Housley", @season_stats.fired_coach(20172018)
  end

  def test_best_shot_ratio
    assert_equal 14, @season_stats.best_shot_ratio(20122013)
  end

  def test_worst_shot_ratio
    assert_equal 9, @season_stats.worst_shot_ratio(20122013)
  end

  def test_most_tickles
    assert_equal 26, @season_stats.most_tickles(20122013)
  end

  def test_fewest_tickles
    assert_equal 1, @season_stats.fewest_tickles(20122013)
  end

  def test_seasons_and_games
    assert_instance_of Array, @season_stats.seasons_and_games(20122013)
  end

  def test_correct_array
    current_season = @season_stats.seasons_and_games(20122013)

    @season_stats.correct_array(current_season).each do |game_team|
      assert_instance_of GameTeam, game_team
    end
  end
end
