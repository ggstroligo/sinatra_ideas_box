# frozen_string_literal: true

module Sinatra
  module IdeaBoxApp
    module Routing
      module Ideas
        def self.registered(app)
          allowed_params = %w(idea_title idea_description)
          permit = lambda do |params, allowed_attributes|
            allowed = params.slice(*allowed_attributes)
            allowed.inject({}) do |hash, (key, value)|
              key = key.split('_').last.to_sym
              hash.merge key => value
            end
          end

          app.get '/' do
            erb :index, locals: { ideas: Idea.all }
          end

          app.post '/' do
            data = permit[params, allowed_params]
            idea = Idea.new(**data)
            idea.save
            redirect '/'
          end

          app.delete '/:id' do |id|
            Idea.delete(id.to_i)
            redirect '/'
          end

          app.get '/:id/edit' do |id|
            idea = Idea.find(id.to_i)
            erb :edit, locals: { id: id, idea: idea }
          end

          app.put '/:id' do |id|
            data = permit[params, allowed_params]

            Idea.update(id.to_i, data)
            redirect '/'
          end
        end
      end
    end
  end
end
