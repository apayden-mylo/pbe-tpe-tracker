desc "This task is called by the Heroku scheduler add-on"
task :update_players => :environment do
  Services::ForumParser.player_parser
end

desc "This task is called by the Heroku scheduler add-on"
task :update_leagues => :environment do
  Services::ForumParser.league_parser('pbe')
  Services::ForumParser.league_parser('milpbe')
end

desc "This task is called by the Heroku scheduler add-on"
task :update_teams => :environment do
  Services::ForumParser.parse_all_teams
end
