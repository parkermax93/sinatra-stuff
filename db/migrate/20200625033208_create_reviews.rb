class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :review 
    end
  end
end
