JCINK_BASE_URL = 'http://probaseballexperience.jcink.net/index.php'

PBE_LEGENDS_EAST_URL = "#{JCINK_BASE_URL}?c=21".freeze
PBE_LEGENDS_WEST_URL = "#{JCINK_BASE_URL}?c=19".freeze

PBE_CHAMPIONS_EAST_URL = "#{JCINK_BASE_URL}?c=22".freeze
PBE_CHAMPIONS_WEST_URL = "#{JCINK_BASE_URL}?c=12".freeze

MILPBE_EAST_URL = "#{JCINK_BASE_URL}?c=23".freeze
MILPBE_WEST_URL = "#{JCINK_BASE_URL}?c=17".freeze

PBE_LEAGUES = [PBE_LEGENDS_EAST_URL, PBE_LEGENDS_WEST_URL, PBE_CHAMPIONS_EAST_URL, PBE_CHAMPIONS_WEST_URL]
MILPBE_LEAGUES = [MILPBE_EAST_URL, MILPBE_WEST_URL]

NAME_REGEX = %r{\[(?<season>S\d+)\](?>[-_\r\0\s]*)(?<name>.+)(?<!\s)(?>\s*-\s*)(?<position>\w+)}

PAGE_COUNT_REGEX = %r{(?>Pages: )\((?<count>\d+)\)}
