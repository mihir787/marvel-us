desc "This task is called by the Heroku scheduler add-on"
task :create_superheros => :environment do
  puts "The world is in danger. Where are all our heroes?"
  Superhero.delete_all
  puts "Superhero count: #{Superhero.count}"
  puts "Creating superheros..."
  Superhero.create_superheros
  Superhero.all.each do |hero|
    puts "- Scoring #{hero.name}..."
    hero.aggregate_sentiment_score
  end
  puts "Superhero count: #{Superhero.count}"
  puts "Truth justice and the American way!!!"
end

task :score_superheroes => :environment do
  puts "Scoring superheroes..."

  Superhero.all.each do |hero|
    puts "- Scoring #{hero.name}..."
    hero.aggregate_sentiment_score
  end
end

task remove_nil_supers: :environment do
  puts "time for some cleaning"
  puts Superhero.where(name: nil)
  supers = Superhero.where(name: nil)
  supers.delete_all
  puts Superhero.where(name: nil)
end
