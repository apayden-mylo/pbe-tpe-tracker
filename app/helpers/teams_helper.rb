module TeamsHelper
  def team_forum_path(team)
    uri = URI.parse(JCINK_BASE_URL)
    uri.query = [uri.query, "showforum=#{team.id}"].compact.join('&')

    uri.to_s
  end

  def active_team?(name)
    !(name == 'Retired' || name == 'Free Agent')
  end

  def league_name(team)
    team.league == 'pbe' ? 'PBE' : 'MiLPBE'
  end
end
