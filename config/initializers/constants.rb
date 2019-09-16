JCINK_BASE_URL = 'http://probaseballexperience.jcink.net/index.php'

PBE_EAST_URL = "#{JCINK_BASE_URL}?c=19".freeze
PBE_WEST_URL = "#{JCINK_BASE_URL}?c=12".freeze

MILPBE_URL = "#{JCINK_BASE_URL}?c=17".freeze

NAME_REGEX = %r{\[(?<season>S\d+)\](?>[-_\r\0\s]*)(?<name>.+)(?<!\s)(?>\s*-\s*)(?<position>\w+)}

PAGE_COUNT_REGEX = %r{(?>Pages: )\((?<count>\d+)\)}
