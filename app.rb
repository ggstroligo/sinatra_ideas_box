# frozen_string_literal: true

class IdeaBoxApp < Sinatra::Base
  require './idea'
  not_found do
    erb :error
  end

  get '/' do
    erb :index, locals: { name: 'Johny' }
  end

  post '/' do
    idea = Idea.new
    idea.save
    'Creating an IDEA!'
  end
end
