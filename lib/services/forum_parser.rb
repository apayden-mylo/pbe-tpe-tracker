module Services
  class ForumParser
    extend Parsers::LeagueParser
    extend Parsers::PlayerParser
    extend Parsers::TeamParser
  end
end
