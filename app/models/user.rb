class User < ActiveRecord::Base
  has_many :tweets

  def self.sentiment_vivekn_service
    @sentiment_vivekn_service ||= SentimentViveknService.new
  end

  def self.twitter_service
    @twitter_service ||= TwitterService.new
  end

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth.provider, uid: auth.uid)

    user.email = auth.info.email
    user.nickname = auth.info.nickname
    user.image_url = auth.info.image
    user.token = auth.credentials.token
    user.oauth_secret = auth.credentials.secret
    user.save
    user
  end


  def tweet_text
    User.twitter_service.collect_tweets(self.nickname)
  end

  def last_tweet
    User.twitter_service.most_recent_tweet(self.nickname)
  end

  def calculate_sentiment_vivekn
    counter = 0
    begin
      counter += 1
      User.sentiment_vivekn_service.sentiment(tweet_text)
    rescue Hurley::Timeout => error
      if counter >= 3
        { confidence: 0 }
      else
        retry
      end
    end
  end

  def calculate_sentiment_alchemy
    counter = 0
    begin
      counter += 1
      AlchemyAPI.search(:sentiment_analysis, text: tweet_text)
    rescue Faraday::TimeoutError => error
      if counter >= 3
        { "score" => 0 }
      else
        retry
      end
    end
  end

  def aggregate_sentiment_score
    score = ((calculate_sentiment_vivekn[:confidence].to_f / 100.0) + (calculate_sentiment_alchemy["score"].to_f * 100.0)).to_i
    self.sentiment_score = score
    self.save
  end

end
