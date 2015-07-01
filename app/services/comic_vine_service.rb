class ComicVineService
  attr_reader :connection

  def initialize
    @connection = Hurley::Client.new('http://www.comicvine.com')
  end

  def character(id)
   params = parse(connection.get("api/characters/?api_key=#{ENV['comic_api_key']}&filter=id:#{id}&format=json").body)[:results].first
  end

  private

  def parse(response)
    JSON.parse(response, symbolize_names: true)
  end

end
