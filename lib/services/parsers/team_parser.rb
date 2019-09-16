module Services
  module Parsers
    module TeamParser
      def parse_all_teams
        Team.all.each do |team|
          parse_team(team.id)
        end
      end

      def parse_team(team_id)
        puts team_id

        uri = URI.parse(JCINK_BASE_URL)
        uri.query = [uri.query, "showforum=#{team_id}"].compact.join('&')

        pages = find_team_pages(uri)

        pages.each do |page|
          page.css('tr.topic-row').each do |row|
            player_data = parse_player_from_team(row)

            unless player_data.nil?
              player_id = player_data[:id]
              player_data[:team_id] = team_id

              player = Player.where(id: player_id).first_or_initialize
              player.assign_attributes(player_data)

              if player.changed? && player.valid?
                player.save
              end
            end
          end
        end
      end

      private

      def find_team_pages(base_uri)
        doc_list = Array.new

        first_doc = Nokogiri::HTML(open(base_uri.to_s), nil, Encoding::UTF_8.to_s)
        doc_list.push(first_doc)

        if (page_text = first_doc.css('span.pagination_pagetxt').first)
          page_count = page_text.text.match(PAGE_COUNT_REGEX)[:count].to_i

          (1..page_count - 1).each do |page|
            uri = base_uri
            uri.query = [uri.query, "st=#{15 * page}"].compact.join('&')
            doc_list.push(Nokogiri::HTML(open(uri.to_s), nil, Encoding::UTF_8.to_s))
          end
        end

        doc_list
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

        data = { id: id, name: name, position: position, regression_season: season, tpe: tpe }
        puts data
        data
      end
    end
  end
end
