class ShortenController < ApplicationController
  def show
    result = Rails.cache.read(params[:shortcode])
    if result.present?
      updated_stats = { url: result[:url],
                        stats: {  startDate: result[:stats][:startDate],
                                  lastSeenDate: Time.current,
                                  redirectCount: result[:stats][:redirectCount] + 1 } }
      Rails.cache.write(params[:shortcode], updated_stats)
      render status: 302, location: result[:url]
    else
      render json: { message: I18n.t(:shortcode_not_found) }, status: 404
    end
  end

  def create
    shortcode = SaveShortenUrlService.new(params[:url], params[:shortcode]).call
    render json: { shortcode: shortcode }, status: 201
  rescue Exceptions::UrlNotExistError => e
    render json: { message: e.message }, status: 400
  rescue Exceptions::InvalidShortcode => e
    render json: { message: e.message }, status: 422
  rescue Exceptions::ShortcodeExistError => e
    render json: { message: e.message }, status: 409
  end

  def stats
    result = Rails.cache.read(params[:shortcode])
    if result.present?
      render json: result[:stats], status: 200
    else
      render json: { message: I18n.t(:shortcode_not_found) }, status: 404
    end
  end
end
