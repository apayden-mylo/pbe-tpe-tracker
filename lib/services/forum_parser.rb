module Services
  class ForumParser
    PBE_URL = 'http://probaseballexperience.jcink.net/index.php?c=12'
    MILPBE_URL = 'http://probaseballexperience.jcink.net/index.php?c=17'

    TEAM_BASE_URL = 'http://probaseballexperience.jcink.net/index.php'

    NAME_REGEX = %r{\[(?<season>S\d+)\](?>\s+)(?<name>.+)(?<!\s)(?>\s*-\s*)(?<position>\w+)}

    class << self
      private

      def parse_team_from_league(row)
        name = row.css('a').first.text
        id = Rack::Utils.parse_nested_query(row.css('span.subforums a.tooltip').first['href'])['showforum']

        { name: name, id: id }
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

      def save_image(team_name, row, league)
        img = row.css('span.forum-desc img').first['src']
        File.open("app/assets/images/#{league}/#{team_name.parameterize.underscore}.png", 'wb') do |file|
          file << open(img).read
        end
      end

      def league_url(league)
        league == 'pbe' ? PBE_URL : MILPBE_URL
      end
    end

    def self.league_parser(league)
      page = Nokogiri::HTML(open(league_url(league)))
      page.css('tr.forum-row').each do |row|
        data = parse_team_from_league(row)
        name = data[:name]
        id = data[:id]

        team = Team.where(id: id).first_or_create(league: league, name: name)
        team.save
        save_image(name, row, league)
      end
    end

    def self.team_parser
      Team.all.each do |team|
        uri = URI.parse(TEAM_BASE_URL)
        uri.query = [uri.query, "showforum=#{team.id}"].compact.join('&')

        page = Nokogiri::HTML(open(uri.to_s))
        page.css('tr.topic-row').each do |row|
          player_data = parse_player_from_team(row)

          unless player_data.nil?
            id = player_data[:id]
            player_data[:team_id] = team.id

            player = Player.where(id: id).first_or_initialize(player_data)
            player.save if player.valid?
          end
        end
      end
    end
  end
end
