# WebpurifyApi

API Wrapper for http://webpurify.com image moderation api

## Installation

Add this line to your application's Gemfile:

    gem 'webpurify_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install webpurify_api

## Usage

```
image = WebpurifyApi::Image.new(api_key: 'XXX', live: false)
res = image.check(image_url)
puts image.status(res['imgid']).inspect
```

See API docs for more informations: http://www.webpurify.com/image-moderation/documentation/



## Contributing

1. Fork it ( https://github.com/veilleperso/webpurify_api_/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request