desc "This task is called by the Heroku scheduler add-on"
task :update_players => :environment do

end

desc "This task is called by the Heroku scheduler add-on"
task :update_leagues => :environment do
  Services::ForumParser.league_parser('pbe')
  Services::ForumParser.league_parser('milpbe')
end

desc "This task is called by the Heroku scheduler add-on"
task :update_teams => :environment do
  Services::ForumParser.team_parser
end
