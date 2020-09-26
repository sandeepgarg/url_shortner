class GenerateUniqueShortcodeService
  def call
    shortcode = nil
    loop do
      shortcode = generate_shortcode
      break unless Rails.cache.fetch(shortcode)
    end
    shortcode
  end

  private

  def generate_shortcode
    chars = [(0..9), ('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
    (0...6).map { chars[rand(chars.length)] }.join
  end
end
