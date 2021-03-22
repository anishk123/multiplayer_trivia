class QaController < ApplicationController
  def random
    begin
      if params[:difficulty].nil?
        difficulty = Question.new.difficulty
      else
        difficulty = params[:difficulty].strip.downcase
      end
      raise ArgumentError.new "#{difficulty} is not a valid difficulty" unless Question.difficulties.keys.include?(difficulty)
      render json: Question.rand_ord.send(difficulty).first.display
    rescue ArgumentError => e
      render json: { status: 422, message: e.message }
    end
  end
end
