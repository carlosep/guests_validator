module GuestsValidator
  module V1
    class Events < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api
      resource :events do
        desc 'Return list of events'
        get do
          events = Event.all
          present events, with: GuestsValidator::Entities::Event
        end
        desc 'Create an event.'
        params do
          requires :event, type: Hash do
            requires :name,       type: String,   desc: 'Name of the event'
            requires :starts_at,  type: DateTime, desc: 'When will the event start?'
            optional :ends_at,    type: DateTime, desc: 'When will the event end?'
            optional :tolerance,  type: Integer,  desc: 'How many minutes is the tolerance? (default is 10 min)'
            optional :capacity,   type: Integer,  desc: 'How many people does this event allow?'
          end
        end
        post do
          @event = Event.create(params[:event])
        end
        desc 'Return a specific event'
        route_param :id do
          get do
            event = Event.find(params[:id])
            present event, with: GuestsValidator::Entities::Event
          end
          resource :guests do
            desc 'Return guests of an event'
            get do
              event = Event.find(params[:id])
              present event.guests
            end

            desc 'Creates a guest'
            params do
              requires :guest, type: Hash do
                requires :name, type: String, desc: 'Name of the guest'
                requires :document, type: String, desc: 'ID of te guest'
              end
            end
            post do
              event = Event.find(params[:id])
              event.guests.create(params[:guest])
            end
          end
        end
      end
    end
  end
end
