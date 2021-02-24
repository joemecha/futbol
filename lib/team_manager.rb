class TeamManager
  attr_reader #add stuff

  def initialize(data)
    #add stuff
  end


  # def team_info(team_id)
  #   {
  #     "team id" => team_id,
  #     "franchise_id" => @teams[team_id].franchise_id
  #
  #   }
  # end

    def team_info
      # Description: A hash with key/value pairs for the following attributes:
      #              team_id, franchise_id, team_name, abbreviation, and link
      # Return Value: Hash
    end

    def best_season
      # Description: Season with the highest win percentage for a team.
      # Return Value: String
    end

    def worst_season
      # Description: Season with the lowest win percentage for a team.
      # Return Value: String
    end

    def average_win_percentage
      # Description: Average win percentage of all games for a team.
      # Return Value: Float
    end

    def most_goals_scored
      # Description: Highest number of goals a particular team has scored
      #              in a single game.
      # Return Value: Integer
    end

    def fewest_goals_scored
      # Description: Lowest numer of goals a particular team has scored
      #              in a single game.
      # Return Value: Integer
    end

    def favorite_opponent
      # Description: Name of the opponent that has the lowest win percentage
      #              against the given team.
      # Return Value: String
    end

    def rival
      # Description: Name of the opponent that has the highest win percentage
      #              against the given team.
      # Return Value: String
    end

end