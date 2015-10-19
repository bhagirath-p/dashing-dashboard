require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = 'rPpxjomzD4PBkjBnYPCLUfcOD'
  config.consumer_secret = 'RzMBztdOnQBJo950EHttr7OdRzVxp4zVb4n5tQHUWzqNfvn82t'
  config.access_token = '254071883-PBs74hYubQZcOvFSNAfnr9evaR5Enqfc46Ckapsq'
  config.access_token_secret = 'fS3oe5ZeyDhtrpGGEo02rmF3wPPd6YukCI9Tj385cTbwG'
end

SCHEDULER.every '2s', :first_in => 0 do |job|
    begin
    timeline = twitter.mentions_timeline
    if timeline
      mentions = timeline.map do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
        p "========output====="
        p tweet.user.name
        p "==================="
      end

      send_event('twitter_mentions', {comments: mentions})
    end    
  rescue Twitter::Error
    puts "\e[33mThere was an error with Twitter\e[0m"
  end
end