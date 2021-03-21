require 'net/http'

class GetInsertQaJob < ApplicationJob
  queue_as :default
  self.queue_adapter = :delayed_job

  # https://opentdb.com/api.php?amount=50&category=9&type=multiple
  QA_API_URL = "https://opentdb.com/api.php"
  RESULTS = 50
  GENERAL_KNOWLEDGE_CATEGORY = 9
  MULTIPLE_CHOICE = "multiple"

  def perform(*args)
    qa_uri = URI(QA_API_URL)
    params = { :amount => 50, :category => GENERAL_KNOWLEDGE_CATEGORY, :type => MULTIPLE_CHOICE }
    qa_uri.query = URI.encode_www_form(params)

    res = JSON.parse Net::HTTP.get(qa_uri)
    if res['results']
      res['results'].each do |qa|
        Question.create(
          question: qa["question"],
          category: qa["category"],
          difficulty: qa["difficulty"],
          answers_attributes: [
            { answer: qa["incorrect_answers"][0], correct: false },
            { answer: qa["incorrect_answers"][1], correct: false },
            { answer: qa["incorrect_answers"][2], correct: false },
            { answer: qa["correct_answer"], correct: true }
          ]
        ) 
      end
    end
  end
end
