class ChangeSentimentScoreDefault < ActiveRecord::Migration
  def change
    change_column :superheros, :sentiment_score, :integer, default: 0
  end
end
