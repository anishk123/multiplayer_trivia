class GetInsertQaJob < ApplicationJob
  queue_as :default
  self.queue_adapter = :delayed_job

  # https://opentdb.com/api.php?amount=50&category=9&type=multiple
  QA_API_URL = "https://opentdb.com/api.php"
  RESULTS = 50
  GENERAL_CATEGORY = 9
  MULTIPLE_CHOICE = "multiple"

  def perform(*args)
    qa_uri = URI(QA_API_URL)
    params = { :amount => 50, :category => GENERAL_CATEGORY, :type => MULTIPLE_CHOICE }
    qa_uri.query = URI.encode_www_form(params)

    res = JSON.parse Http.get(qa_uri).to_s
    puts res.inspect 
  end
end
