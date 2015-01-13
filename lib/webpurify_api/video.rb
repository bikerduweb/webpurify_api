class WebpurifyApi::Video < WebpurifyApi::Base
  def initialize(api_key: nil, live: nil)
    super(api_key: api_key, live: live, endpoint: "https://im-api1.webpurify.com/video/services/rest/")
  end

  # callback url receive a get request  with +imgid+ and +status+ parameters
  # status: 1 = approved , status: 2 = declined
  def check(url, custom_video_id: nil)
    res = do_request(:vidcheck, params: {vidurl: url, customvidid: custom_video_id})
    res
  end

  def status(video_id: nil, custom_video_id: nil)
    params = custom_video_id.nil? ? {vidid: video_id} : {customvidid: custom_video_id}
    do_request(:vidstatus, params: params)
  end

  def account
    do_request(:vidaccount)
  end
end
