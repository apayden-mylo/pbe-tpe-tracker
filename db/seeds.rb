# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Team.create! do |team|
  team.name = 'Providence Crabs'
  team.id = 59
  team.league = 'pbe'
end

# A.C. Payton
PitchingAttr.create! do |attrs|
  attrs.velocity = '89 - 91'
  attrs.move_l = 61
  attrs.move_r = 61
  attrs.con_l = 62
  attrs.con_r = 62
  attrs.stamina = 61
  attrs.hold = 50
  attrs.pitch_1 = 56
  attrs.pitch_2 = 63
  attrs.pitch_3 = 55
  attrs.pitch_4 = 55
  attrs.pitch_5 = 0
  attrs.player_id = 5097
end

Player.create! do |attrs|
  attrs.id = 5097
  attrs.name = 'A.C. Payton'
  attrs.draft_season = 'S10'
  attrs.tpe = 488
  attrs.position = 'SP'
  attrs.team_id = 59
end

# Jahseh Tentacion
Player.create! do |attrs|
  attrs.id = 4673
  attrs.name = 'Jahseh Tentacion'
  attrs.draft_season = 'S9'
  attrs.tpe = 710
  attrs.position = 'C'
  attrs.team_id = 59
end

HittingAttr.create! do |attrs|
  attrs.babip_l = 65
  attrs.babip_r = 65
  attrs.av_k_l = 60
  attrs.av_k_r = 55
  attrs.gap_l = 33
  attrs.gap_r = 30
  attrs.power_l = 65
  attrs.power_r = 63
  attrs.eye_l = 54
  attrs.eye_r = 50
  attrs.speed = 50
  attrs.steal = 50
  attrs.bunt = 25
  attrs.player_id = 4673
end

FieldingAttr.create! do |attrs|
  attrs.range = 25
  attrs.error = 30
  attrs.arm = 50
  attrs.dp = 20
  attrs.catch = 73
  attrs.player_id = 4673
end






