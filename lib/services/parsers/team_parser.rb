module Services
  module Parsers
    module TeamParser
      def parse_all_teams
        Team.all.each do |team|
          parse_team(team.id)

          # page = Nokogiri::HTML(open(uri.to_s), nil, Encoding::UTF_8.to_s)
          # page.css('tr.topic-row').each do |row|
          #   player_data = parse_player_from_team(row)
          #
          #   unless player_data.nil?
          #     id = player_data[:id]
          #     player_data[:team_id] = team.id
          #
          #     player = Player.where(id: id).first_or_initialize(player_data)
          #     player.save if player.valid?
          #   end
          # end
        end
      end

      def parse_team(team_id)
        doc_list = Array.new

        uri = URI.parse(JCINK_BASE_URL)
        uri.query = [uri.query, "showforum=#{team_id}"].compact.join('&')

        first_doc = Nokogiri::HTML(open(uri.to_s), nil, Encoding::UTF_8.to_s)
        doc_list.push(first_doc)

        doc_list = (doc_list + find_team_pages(first_doc))

        doc_list.each do |page|
          page.css('tr.topic-row').each do |row|
            player_data = parse_player_from_team(row)

            unless player_data.nil?
              player_id = player_data[:id]
              player_data[:team_id] = team_id

              player = Player.where(id: player_id).first_or_initialize(player_data)
              player.save if player.valid?
            end
          end
        end
      end

      private

      def find_team_pages(doc)
        pages = doc.css('span.pagination').first

        pages.css('a.pagination_page').map do |page|
          Nokogiri::HTML(open(page['href'].to_s), nil, Encoding::UTF_8.to_s)
        end
      end

      def parse_player_from_team(row)
        name, position, season = nil

        link = row.css('a').first
        id = Rack::Utils.parse_nested_query(link['href'])['showtopic']
        tpe = (matches = row.css('span.desc').first.text.match(%r{\d+})) ? matches[0] : 100

        if (matches = link.text.match(NAME_REGEX))
          season = matches[:season]
          name = matches[:name]
          position = matches[:position]
        end

        { id: id, name: name, position: position, regression_season: season, tpe: tpe }
      end
    end
  end
end
