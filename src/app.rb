# frozen_string_literal: true

class IdeaBoxApp < Sinatra::Base
  require 'pry'

  require_relative 'models/idea'
  require_relative 'routes/ideas'

  set :method_override, true
  enable :ideas

  register Sinatra::IdeaBoxApp::Routing::Ideas

  not_found do
    erb :error
  end
end
