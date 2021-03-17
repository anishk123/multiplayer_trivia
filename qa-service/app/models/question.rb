class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  enum category: {  
    general_knowledge: 'General Knowledge',
    science: 'Science & Nature', 
    entertainment_music: 'Entertainment: Music',
    entertainment_film: 'Entertainment: Film',
    animals: 'Animals', 
    geography: 'Geography', 
    history: 'History', 
    politics: 'Politics', 
    sports: 'Sports'
  }
  enum difficult: {
    easy: 'easy', 
    medium: 'medium', 
    hard: 'hard'
  }

  scope :correct_ans, -> { joins(:answers).where(Answer.correct) }
  scope :wrong_ans, -> { joins(:answers).where(!Answer.correct) }
  scope :rand_ord_ans, -> { joins(:answers).order(answer: :rand) }
end
