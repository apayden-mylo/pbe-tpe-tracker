module Services
  module Parsers
    module PlayerParser
      def player_parser
        Player.all.each do |player|
          puts player.updated_at.zone

          uri = URI.parse(JCINK_BASE_URL)
          uri.query = [uri.query, "showtopic=#{player.id}"].compact.join('&')

          page = Nokogiri::HTML(open(uri.to_s), nil, Encoding::UTF_8.to_s)

          edit = page.css('span.edit').first.content

          if (matches = edit.match(EDIT_REGEX))
            puts matches[:update]
          else
            puts 'No Update'
          end
        end
      end
    end
  end
end
