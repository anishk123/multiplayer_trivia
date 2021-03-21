class AddUniqIndexToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :question, :string
    add_index :questions, :question, unique: true
  end
end
