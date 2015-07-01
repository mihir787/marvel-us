class AddSentimentScoreToSuperheros < ActiveRecord::Migration
  def change
    add_column :superheros, :sentiment_score, :integer
  end
end
