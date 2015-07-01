class DropSuperheroesTable < ActiveRecord::Migration
  def change
    drop_table :superheroes
  end
end
