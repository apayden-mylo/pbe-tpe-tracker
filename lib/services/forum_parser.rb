module Services
  class ForumParser
    PBE_URL = 'http://probaseballexperience.jcink.net/index.php?c=12'
    MILPBE_URL = 'http://probaseballexperience.jcink.net/index.php?c=17'

    TEAM_BASE_URL = 'http://probaseballexperience.jcink.net/index.php'

    class << self
      private

      def parse_row(row)
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

      def league_url(league)
        league == 'pbe' ? PBE_URL : MILPBE_URL
      end
    end

    def self.league_parser(league)
      page = Nokogiri::HTML(open(league_url(league)))
      page.css('tr.forum-row').each do |row|
        data = parse_row(row)
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

        puts uri.to_s
      end
    end
  end
end
