module Exceptions
  class ShortcodeExistError < StandardError
    def message
      I18n.t(:shortcode_exist)
    end
  end

  class UrlNotExistError < StandardError
    def message
      I18n.t(:url_not_found)
    end
  end

  class InvalidShortcode < StandardError
    def message
      I18n.t(:invalid_shortcode)
    end
  end
end
