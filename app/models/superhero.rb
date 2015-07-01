class Superhero < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :comic_vine_id, presence: true, uniqueness: true
  enum       gender: { male: "1", female: "2" }

  SUPER_IDS = ['1699','1440','2114','1441','1295','1420','1445','1457','1462','1320',
  '1442','5010','1456','1459','1460','4562','4444','3202','1940','5017','2112',
  '1499','1475','1464','1260','8429','1455','1943','3182','1469','1345','1449',
  '1467','3554','2497','2503','3534','1320','5047','1466','1478',
  '1447','1505','7807','1456','1483','1256','1444','1802','1467','1473','1604','1699',
  '14451','1807','1960','1702','1529','1686','1438','2357','1428','1686','1487',
  '1698','1464','1696','1332','1697','2047','1446','1342','2475',
  '1489','1332','1818','1254']

  scope :ordered_score, -> { Superhero.order(:sentiment_score) }

  def self.categorized_scores
    @categorized_scores ||= Superhero.formatted_categorized_scores
  end

  def self.formatted_categorized_scores
    categorized_scores = {}
    categorized_scores[:chaotic_evil] = Superhero.chaotic_evil
    categorized_scores[:lawful_evil] = lawful_evil
    categorized_scores[:chaotic_good] = chaotic_good
    categorized_scores[:lawful_good] = lawful_good
    {categorized_scores: categorized_scores}
  end

  def self.chaotic_evil
    ce = {}
    Superhero.ordered_score.where("sentiment_score <= ?", -50).pluck(:name, :sentiment_score).each do |p|
      ce[p.first] = p.last
    end
    ce
  end

  def self.lawful_evil
    le = {}
    Superhero.ordered_score.where("sentiment_score < ? AND sentiment_score > ?", 0, -50).pluck(:name, :sentiment_score).each do |p|
      le[p.first] = p.last
    end
    le
  end

  def self.chaotic_good
    cg = {}
    Superhero.ordered_score.where("sentiment_score < ? AND sentiment_score >= ?", 50, 0).pluck(:name, :sentiment_score).each do |p|
      cg[p.first] = p.last
    end
    cg
  end

  def self.lawful_good
    lg = {}
    Superhero.ordered_score.where("sentiment_score >= ?", 50).pluck(:name, :sentiment_score).each do |p|
      lg[p.first] = p.last
    end
    lg
  end

  def self.create_superheros
    SUPER_IDS.each do |id|
      access(id)
    end
  end

  def self.service
      @service ||= ComicVineService.new
  end

  def self.access(id)
    params = SuperheroParameterParser.parse(Superhero.service.character(id))
    Superhero.create(params)
  end

  def sentiment_vivekn_service
    @sentiment_vivekn_service ||= SentimentViveknService.new
  end

  def calculate_sentiment_vivekn
    counter = 0
    begin
      counter += 1
      sentiment_vivekn_service.sentiment("#{self.descripton}")
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
      AlchemyAPI.search(:sentiment_analysis, text: "#{self.deck} + #{self.descripton}")
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

  def self.hero_view(num)
    limit(num).order("RANDOM()")
  end

end
