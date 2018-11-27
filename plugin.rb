# name: avatar-name-first-letter
# about: Add name_first_letter as an option for external_system_avatars_url
# version: 0.1
# author: Jay Pfaffman
# url: https://github.com/pfaffman/discourse-avatar-name-first-letter.git

after_initialize do
  require_dependency 'user'
  class ::User

    def self.system_avatar_template(username)
      # TODO it may be worth caching this in a distributed cache, should be benched
      if SiteSetting.external_system_avatars_enabled
        url = SiteSetting.external_system_avatars_url.dup
        url.gsub! "{color}", letter_avatar_color(username.downcase)
        url.gsub! "{username}", username
        url.gsub! "{name_first_letter}", get_name_first_letter(username)
        url.gsub! "{first_letter}", username[0].downcase
        url.gsub! "{hostname}", Discourse.current_hostname
        url
      else
        "#{Discourse.base_uri}/letter_avatar/#{username.downcase}/{size}/#{LetterAvatar.version}.png"
      end
    end

    def self.letter_avatar_color(username)
      username ||= ""
      color = User::COLORS[Digest::MD5.hexdigest(username)[0...15].to_i(16) % User::COLORS.length]
      color.map { |c| c.to_s(16).rjust(2, '0') }.join
    end

    def self.get_name_first_letter(username)
      if user = User.find_by_username(username)
        name = user.name.presence ? user.name.gsub(/[^a-zA-Z0-9]/,'') : ''
      else
        name = ''
      end
      name.presence ? user.name.gsub(/\W+/,'')[0].downcase : username[0].downcase
    end

    # Workshop palette
    COLORS = [[89, 91, 134],
      [73, 75, 110],
      [247, 197, 159],
      [230, 189, 157],
      [133, 186, 161],
      [115, 161, 139],
      [144, 112, 140],
      [117, 91, 114],
      [164, 190, 243],
      [146, 169, 217],
      [160, 113, 120],
      [135, 95, 101],
      [231, 107, 116],
      [207, 96, 103],
      [237, 164, 189],
      [212, 146, 169]]

  end
end
