class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :name
      t.integer :time_per_question
      t.boolean :time_independent
      t.boolean :question_time_setting
      
      t.timestamps null: false
    end
  end
end
