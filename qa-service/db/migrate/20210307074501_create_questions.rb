class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.integer :category
      t.integer :difficulty
      t.text :question

      t.timestamps
    end
  end
end
