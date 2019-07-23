module PlayersHelper
  def player_forum_path(player)
    uri = URI.parse(JCINK_BASE_URL)
    uri.query = [uri.query, "showtopic=#{player.id}"].compact.join('&')

    uri.to_s
  end
end
