class CreateQuestionDifficulties < ActiveRecord::Migration[6.1]
  def up
    execute "ALTER TABLE questions ALTER difficulty DROP DEFAULT;"
    execute <<-DDL
      CREATE TYPE question_difficulties AS ENUM (
        'easy', 'medium', 'hard'
      );
    DDL
    change_column :questions, :difficulty, "question_difficulties USING difficulty::text::question_difficulties"
  end

  def down
    change_column :questions, :difficulty, "integer USING difficulty::text::integer"
    execute "DROP TYPE question_difficulties;"
  end
end
