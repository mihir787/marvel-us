class AddScoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sentiment_score, :integer, default: 0
  end
end
