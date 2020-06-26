class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :review 
      t.integer :game_id
      t.integer :user_id
    end 
  end
end
