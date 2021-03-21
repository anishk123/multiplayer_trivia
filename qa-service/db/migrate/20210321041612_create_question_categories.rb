class CreateQuestionCategories < ActiveRecord::Migration[6.1]
  def up
    execute "ALTER TABLE questions ALTER category DROP DEFAULT;"
    execute <<-DDL
      CREATE TYPE question_categories AS ENUM (
        'General Knowledge', 'Science & Nature', 'Entertainment: Music', 'Entertainment: Film', 'Animals', 'Geography', 'History', 'Politics', 'Sports'
      );
    DDL
    change_column :questions, :category, "question_categories USING category::text::question_categories"
  end

  def down
    change_column :questions, :category, "integer USING category::text::integer"
    execute "DROP TYPE question_categories;"
  end
end
