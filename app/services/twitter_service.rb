class TwitterService
  attr_reader :twitter

  def initialize
    @twitter = Twitter::REST::Client.new do |config|
      config.consumer_key =   ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret =   ENV['TWITTER_CONSUMER_SECRET']
      config.access_token =   ENV['TWITTER_YOUR_ACCESS_TOKEN']
      config.access_token_secret =  ENV['TWITTER_YOUR_ACCESS_SECRET']
    end
  end

  def collect_tweets(user)
    twitter.user_timeline(user, count: 10).collect do |tweet|
      "#{tweet.text}"
    end.join(". ")
  end

  def most_recent_tweet(user)
    twitter.user_timeline(user, count: 1).first.text
  end

  def self.tweet(user, superhero)
    client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['client_id']
        config.consumer_secret     = ENV['client_secret']
        config.access_token        = user.token
        config.access_token_secret = user.oauth_secret
    end
    client.update("My Marvelus Superhero match is #{superhero.name}! Who's yours?\nhttp://marvel-us.herokuapp.com/")
  end

end
