class SuperheroParameterParser

  def self.parse(parameter)
    params = {}
    params[:deck] = parameter[:deck]
    params[:descripton] = parameter[:description]
    params[:gender] = parameter[:gender]
    params[:name] = parameter[:name]
    params[:real_name] = parameter[:real_name]
    params[:image] = parameter[:image][:medium_url]
    params[:birthday] = parameter[:birth]
    params[:publisher] = parameter[:publisher][:name]
    params[:comic_vine_id] = parameter[:id]
    params
  end
end
