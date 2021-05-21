Rails.application.routes.draw do
  get 'questions', to: 'question#index'
  post 'import_questions', to: 'question#questions_import'
end
