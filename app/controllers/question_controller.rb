class QuestionController < ApplicationController
  def index
  	@questions ||= Question.all
  end

  def questions_import
  	uploaded_file = params[:file]
  	count = 0
  	CSV.foreach(uploaded_file.path) do |row_data|
  		if count > 0
  			store_data(row_data)
  		end
  		count +=1
  	end

  	redirect_to '/questions'
  end

  # Private methods
  private
  def store_data(row_data)
  	question_data = 0
  	role_data = 0
  	mapping_data = 0
  	unless row_data.empty?
	  	create_role( row_data [6] )
	  	create_mapping( row_data[9] )
	  	question_data = row_data.select.with_index { |val, index| [0,6,9].include?(index) == false }
	  	create_question( question_data, row_data [6], row_data[9])
  	end
  end

  def create_question(questions, role, mapping)
  	role_id = Role.find_by(title: role).id
  	mapping_id = Mapping.find_by(title: mapping).id
  	questions_title = Question.pluck(:title)
  	unless questions_title.include?(questions[0])
	  	question = Question.new
	  	question.title = questions[0]
	  	question.team_stages = questions[1]
	  	question.appears = questions[2]
	  	question.frequency = questions[3]
	  	question.rate_type = questions[4]
	  	question.required = questions[5]
	  	question.condition = questions[6]
	  	question.role_id = role_id
	  	question.mapping_id = mapping_id

	  	question.save!
  	end
  end

  def create_role(title)
  	roles_title = Role.pluck(:title)
  	unless roles_title.include?(title)
  		role = Role.new
  		role.title = title

  		role.save!
  	end
  end

  def create_mapping(title)
  	mapping_titles = Mapping.pluck(:title)
		unless mapping_titles.include?(title)
		  mapping = Mapping.new
		  mapping.title = title

		  mapping.save!
		end
  end
end
