require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/opinion')
require('./lib/question')
require('./lib/survey')
require('rspec')
require('pry')
require('pg')

get('/')do
  @surveys = Survey.all()
  erb(:index)
end

post('/add_survey')do
  name = params.fetch("name")
  survey = Survey.new({:name => name})
  survey.save()
  @surveys = Survey.all()
  erb(:index)
end

get('/survey/:id')do
  id = params[:id].to_i
  @survey = Survey.find(id)
  @questions = Question.all()
  erb(:survey)
end

post('/add_question')do
  question = params.fetch('question')
  survey_id = params.fetch('survey_id')
  question = Question.new({:question => question, :survey_id => survey_id})
  question.save()
  @survey = Survey.find(survey_id)
  erb(:survey)
end

get('/delete/:id')do
  id = params[:id].to_i
  @survey = Survey.find(id)
  erb(:delete_question)
end

get('/edit/:id')do
  id = params[:id].to_i
  @survey = Survey.find(id)
  erb(:edit_question)
end

delete('/')do
  question_id = params.fetch('id').to_i
  question =Question.find(question_id)
  id = question.survey_id
  question.delete()
  @survey = Survey.find(id)
  erb(:delete_question)
end

patch('/')do
  questions = params.fetch('question')
  id = params.fetch('id').to_i
  questions.each do |question|
    Question.update((question['id']).to_i, :question => question['value'])
  end
  @survey = Survey.find(id)
  erb(:survey)
end

post('/answer')do
  question = params.fetch('question').to_i
  id = params.fetch('survey_id').to_i
  answer = params.fetch('answer')
  opinion = Opinion.new({:opinion => answer, :question_id => question})
  opinion.save()
  @survey = Survey.find(id)
  erb(:survey)
end
