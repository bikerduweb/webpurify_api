class WebpurifyApi::Base
  attr_accessor :api_key, :endpoint

  def initialize(api_key: nil, live: nil, endpoint: nil)
    self.api_key = api_key || ENV['WEBPURIFY_APIKEY']
    self.live = live.nil? ? ENV['WEBPURIFY_LIVE'].to_s == 'true' : live
    self.endpoint = endpoint if endpoint
  end

  def live?
    !!self.live
  end

  def logger
    return @logger if defined?(@logger)
    @logger = defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
  end

  def logger=(val)
    @logger = val
  end

  def error_message_for(code)
    case code.to_i
    when 100 then "Invalid API Key"
    when 101 then "API Key is inactive"
    when 102 then "API Key is missing in request"
    when 103 then "Not a valid URL"
    when 105 then "Unable to locate image"
    when 106 then "Out of Requests"
    else "Unknown error #{code}"
    end
  end

  protected

  attr_accessor :live

  def do_request(method, options = {})
    return false if api_key.blank?
    return false if endpoint.blank?
    return false unless valid_method?(method)

    url = build_url_for(method, options.delete(:params))
    res = RestClient.get(url, content_type: :json, accept: :json)
    if res.body.to_s.match('<?xml')
      # errors seems to be always returned in xml, whatever the format we ask
      (Hash.from_xml(res.body) || {})['rsp']
    else
      (JSON.parse(res.body) || {})['rsp']
    end
  rescue RestClient::BadGateway, RestClient::ServiceUnavailable => err
    logger.error("#{err.inspect}")
    {}
  end

  private

  def valid_method?(method)
    %w(imgcheck imgstatus imgaccount).include?(method.to_s)
  end

  def request_method(method)
    live_request?(method) ? "webpurify.live.#{method}" : "webpurify.sandbox.#{method}"
  end

  def live_request?(method)
    method.to_s == 'imgaccount' ? true : live?
  end

  def build_url_for(method, params = nil)
    params ||= {}
    params.reverse_merge!(format: 'json', api_key: self.api_key)
    params[:method] = request_method(method)
    query = params.select { |k, v| !v.blank? }.collect { |k, v| "#{k}=#{CGI.escape(v.to_s)}"}.join("&")
    "#{endpoint}?#{query}"
  end
end
