require 'rails_helper'

describe GuestsValidator::V1::Events do
  before(:all) { 10.times { create(:event) } }
  let(:events) { Event.all }
  it 'list all events' do
    get '/api/v1/events'
    expect(response.body).to include(events.pluck(:name).sample)
  end
  it 'list one event' do
    get "/api/v1/events/#{events.first.id}"
    expect(response.body).to include(events.first.id.to_s)
    expect(response.body).to include(events.first.name)
  end
  describe 'POST /api/v1/events' do
    context 'with valid parameters' do
      it 'creates a new event' do
        params = { event: { name: 'event_test',
                            starts_at: Time.zone.now + 2.hours,
                            ends_at: Time.zone.now + 5.hours,
                            tolerance: 10,
                            capacity: 200 } }

        expect { post '/api/v1/events', params: params }.to change(Event, :count).by(+1)
        expect(response.status).to eq 201
        expect(response.body).to include('event_test')
        expect(Event.last.name).to eq('event_test')
      end
    end
    context 'with invalid parameters' do
      it 'does not create an event' do
        expect { post '/api/v1/events', params: { event: {} } }.to change(Event, :count).by(0)
        expect(response.status).to eq 400
        expect(response.body).to include('event[name] is missing, event[starts_at] is missing')
      end
    end
  end
end
