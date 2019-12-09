# frozen_string_literal: true

class IdeaBoxApp < Sinatra::Base
  require './idea'
  not_found do
    erb :error
  end

  get '/' do
    erb :index, locals: { ideas: Idea.all }
  end

  post '/' do
    idea = Idea.new(params['idea_title'], params['idea_description'])
    idea.save
    redirect '/'
  end
end
