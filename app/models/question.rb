# Question Model class
class Question < ApplicationRecord
  belongs_to :role
  belongs_to :mapping

  def store_data(row_data)
    unless row_data.empty?
	    create_role(row_data [6])
      create_mapping(row_data[9])
      question_data = row_data.select.with_index { |val, index| [0, 6, 9].include?(index) == false }
      create_question(question_data, row_data [6], row_data[9])
    end
  end

  def create_question(questions, role, mapping)
    questions_title = Question.pluck(:title)
    reurn if questions_title.include?(questions[0])
    role_id = Role.find_by(title: role).id
    mapping_id = Mapping.find_by(title: mapping).id
    self.title = questions[0]
    self.team_stages = questions[1]
    self.appears = questions[2]
    self.frequency = questions[3]
    self.rate_type = questions[4]
    self.required = questions[5]
    self.condition = questions[6]
    self.role_id = role_id
    self.mapping_id = mapping_id

    self.save!
  end

  def create_role(title)
    roles_title = Role.pluck(:title)
    return if roles_title.include?(title)
    role = Role.new
    role.title = title

    role.save!
  end

  def create_mapping(title)
    mapping_titles = Mapping.pluck(:title)
    return if mapping_titles.include?(title)
    mapping = Mapping.new
    mapping.title = title

    mapping.save!
  end

end