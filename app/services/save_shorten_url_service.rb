class SaveShortenUrlService
  attr_reader :url, :shortcode

  def initialize(url, shortcode)
    @url = url
    @shortcode = shortcode.presence || GenerateUniqueShortcodeService.new.call
  end

  def call
    raise Exceptions::UrlNotExistError if url.blank?
    raise Exceptions::InvalidShortcode unless valid_shortcode?
    raise Exceptions::ShortcodeExistError if Rails.cache.read(shortcode).present?

    Rails.cache.write(shortcode, { url: url,
                                   stats: { startDate: Time.current,
                                            lastSeenDate: nil,
                                            redirectCount: 0 } })
    shortcode
  end

  private

  def valid_shortcode?
    shortcode.match(/^[0-9a-zA-Z_]{6}$/)
  end
end
