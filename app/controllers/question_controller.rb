# Question Controller
class QuestionController < ApplicationController
  def index
    @questions = Question.all
  end

  def questions_import
    if params[:file].blank?
      flash[:error] = 'Please select the file.'
      return
    end
    uploaded_file = params[:file]
    count = 0
    CSV.foreach(uploaded_file.path) do |row_data|
      Question.new.store_data(row_data) if count > 0
      count += 1
    end
    redirect_to '/questions'
  end
end
