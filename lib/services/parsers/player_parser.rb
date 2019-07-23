module Services
  module Parsers
    module PlayerParser
      def player_parser
        Player.all.each do |player|
          uri = URI.parse(JCINK_BASE_URL)
          uri.query = [uri.query, "showtopic=#{player.id}"].compact.join('&')

          page = Nokogiri::HTML(open(uri.to_s), nil, Encoding::UTF_8.to_s)
        end
      end
    end
  end
end
