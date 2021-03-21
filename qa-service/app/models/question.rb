class Question < ApplicationRecord
  validates_uniqueness_of :question

  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers

  enum category: {  
    general_knowledge: "General Knowledge",
    science: "Science & Nature", 
    entertainment_music: "Entertainment: Music",
    entertainment_film: "Entertainment: Film",
    animals: "Animals", 
    geography: "Geography", 
    history: "History", 
    politics: "Politics", 
    sports: "Sports"
  }, _default: "General Knowledge"
  enum difficulty: {
    easy: "easy", 
    medium: "medium", 
    hard: "hard"
  }, _default: "easy"

  scope :rand_ord, -> { order("RANDOM()") }
  scope :rand_easy_q, -> { rand_ord.easy.first }
  scope :rand_medium_q, -> { rand_ord.medium.first }
  scope :rand_hard_q, -> { rand_ord.hard.first }

  scope :ans_with_selected_cols, -> { select(:question, :category, :difficulty, :answer).joins(:answers) }
  scope :correct_ans_by_q, -> (question) { ans_with_selected_cols.merge(Answer.correct).where(id: question.id).first }
  scope :wrong_ans_by_q, -> (question) { ans_with_selected_cols.merge(Answer.incorrect).where(id: question.id).map(&:answer) }
  scope :rand_ord_ans_by_q, -> (question) { ans_with_selected_cols.order("RANDOM()").where(id: question.id).map(&:answer) }

  def answers_list
    answers.map(&:answer)
  end

  def correct_ans?(ans_text)
    self.class.correct_ans_by_q(self).answer.strip.downcase == ans_text.strip.downcase 
  end
end
