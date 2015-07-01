class SentimentViveknService
  attr_reader :connection
  attr_reader :full_sanitizer

  def initialize
    @connection = Hurley::Client.new('http://sentiment.vivekn.com')
    @full_sanitizer = Rails::Html::FullSanitizer.new
  end

  def sentiment(text)
    bio = {"txt" => full_sanitizer.sanitize(text)}
    parse(connection.post("api/text/", bio).body)[:result]
  end

  private

  def parse(response)
    JSON.parse(response, symbolize_names: true)
  end

 end
