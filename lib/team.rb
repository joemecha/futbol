class Team

  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(data)
    @team_id = data[:team_id].to_i
    @franchise_id = data[:franchiseid].to_i
    @team_name = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
  end

  def team_info
    {
      team_id: @team_id,
      franchise_id: @franchise_id,
      team_name: @team_name,
      abbreviation: @abbreviation,
      link: @link
    }
  end

end
