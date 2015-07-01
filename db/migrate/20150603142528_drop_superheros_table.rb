class DropSuperherosTable < ActiveRecord::Migration
  def change
    drop_table :superheros
  end
end
