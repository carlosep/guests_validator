require 'rails_helper'

describe GuestsValidator::V1::Guests do
  before(:all) do
    @event = create(:event)
    @guest = create(:guest, event: @event)
    @guest2 = create(:guest, event: @event)
  end
  it 'list guests of an event' do
    get "/api/v1/events/#{@event.id}/guests"
    expect(response.body).to include(@guest.name)
    expect(response.body).to include(@guest2.name)
  end
  it 'list one guest' do
    get "/api/v1/guests/#{@guest.id}"
    expect(response.body).to include(@guest.id.to_s)
    expect(response.body).to include(@guest.name)
  end
  describe 'POST /api/v1/events/:id/guests' do
    context 'with valid parameters' do
      it 'creates a new guest' do
        params = { event: { name: 'guest_test',
                            document: Faker::IDNumber.brazilian_citizen_number } }
        expect { post "/api/v1/events/#{@event.id}/guests", params: params }.to change(Guest, :count).by(+1)
        expect(response.status).to eq 201
        expect(response.body).to include('guest_test')
        expect(Guest.last.name).to eq('guest_test')
      end
    end
    context 'with invalid parameters' do
      it 'does not create a guest' do
        expect { post "/api/v1/events/#{@event.id}/guests", params: { guest: {} } }.to change(Guest, :count).by(0)
        expect(response.status).to eq 400
        expect(response.body).to include('event[name] is missing')
      end
    end
  end
  describe 'PATCH /api/v1/guests/:id' do
    before(:each) do
      event = create(:event, name: 'Event for the rich and famous',
                       starts_at: Time.current,
                       ends_at: Time.current + 2.hours)
      @guest = create(:guest, event: event, name: 'Mr Rich and famous')
    end
    context 'Guest arrives early' do
      it 'updates the guest attributes' do
        travel -30.minutes do
          post "/api/v1/guests/#{@guest.id}"
        end
        expect(response.body).to include('early')
      end
    end
    context 'Guest arrives on time' do
      it 'updates the guest attributes' do
        post "/api/v1/guests/#{@guest.id}"
        expect(response.body).to include('on_time')
      end
    end
    context 'Guest arrives late' do
      it 'updates the guest attributes' do
        travel 90.minutes do
          post "/api/v1/guests/#{@guest.id}"
        end
        expect(response.body).to include('late')
      end
    end
  end
end
