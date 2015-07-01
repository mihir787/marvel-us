class DropSuperheros < ActiveRecord::Migration
  def change
    drop_table :superheros
  end
end
