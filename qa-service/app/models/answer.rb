class Answer < ApplicationRecord
  belongs_to :question

  scope :correct, -> { where(correct: true) }
  scope :incorrect, -> { where(correct: false) }
end
