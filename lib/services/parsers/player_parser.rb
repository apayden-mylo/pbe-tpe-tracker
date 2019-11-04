module Services
  module Parsers
    module PlayerParser
      def parse_all_players
        # Team.active.each do |team|
        #   puts team.name
        #   team.players.each do |player|
        #     parse_player(player)
        #   end
        # end


        Team.find(59).players.each do |player|
          parse_player(player)
        end
      end

      def parse_player(player)
        uri = URI.parse(JCINK_BASE_URL)
        uri.query = [uri.query, "showtopic=#{player.id}"].compact.join('&')

        page = Nokogiri::HTML(open(uri.to_s), nil, Encoding::UTF_8.to_s)
        info = page.css('div.postcolor').first
        info.css('br').each{ |br| br.replace("\n") }

        attributes = parse_attributes(info)
        attributes[:player_id] = player.id

        if player.pitcher?
          set_pitching_attributes(attributes)
        elsif player.hitter?
          set_hitting_attributes(attributes)
          set_fielding_attributes(attributes)
        end
      end

      def parse_attributes(page_data)
        attributes = {}

        page_data.text.each_line do |line|
          if(matches = line.match(ATTR_REGEX))
            attributes[matches[:attr]] = matches[:val]
          end
        end

        attributes
      end

      private
      def set_pitching_attributes(attrs)
        pitching_attrs = PitchingAttr.where(player_id: attrs[:player_id]).first_or_initialize
        set_attributes(attrs, pitching_attrs)

        if pitching_attrs.changed? && pitching_attrs.valid?
          pitching_attrs.save
        end
      end

      def set_hitting_attributes(attrs)
        hitting_attrs = HittingAttr.where(player_id: attrs[:player_id]).first_or_initialize
        set_attributes(attrs, hitting_attrs)

        if hitting_attrs.changed? && hitting_attrs.valid?
          hitting_attrs.save
        end
      end

      def set_fielding_attributes(attrs)
        fielding_attrs = FieldingAttr.where(player_id: attrs[:player_id]).first_or_initialize
        set_attributes(attrs, fielding_attrs)

        if fielding_attrs.changed? && fielding_attrs.valid?
          fielding_attrs.save
        end
      end

      def set_attributes(attrs, attr_obj)
        attrs.each do |key, value|
          attr_obj.set_attribute(key, value)
        end
      end
    end
  end
end
