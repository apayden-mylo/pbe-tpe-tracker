module Services
  module Parsers
    module LeagueParser
      def league_parser(league)
        league_urls(league).each do |url|
          page = Nokogiri::HTML(open(url), nil, Encoding::UTF_8.to_s)
          page.css('tr.forum-row').each do |row|
            data = parse_team_from_league(row)
            name = data[:name]
            id = data[:id]

            Team.where(id: id).first_or_create.update(league: league, name: name)
            save_image(name, row, league)
          end
        end
      end

      private

      def parse_team_from_league(row)
        name = row.css('a').first.text
        id = Rack::Utils.parse_nested_query(row.css('span.subforums a.tooltip').first['href'])['showforum']

        { name: name, id: id }
      end

      def save_image(team_name, row, league)
        img = row.css('span.forum-desc img').first['src']
        File.open("app/assets/images/#{league}/#{team_name.parameterize.underscore}.png", 'wb') do |file|
          file << open(img).read
        end
      end

      def league_urls(league)
        league == 'pbe' ? PBE_LEAGUES : MILPBE_LEAGUES
      end
    end
  end
end
