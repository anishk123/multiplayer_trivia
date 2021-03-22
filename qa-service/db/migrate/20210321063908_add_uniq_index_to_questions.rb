class AddUniqIndexToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_index :questions, :question, unique: true
  end
end
