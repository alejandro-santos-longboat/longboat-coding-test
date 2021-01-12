require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
    describe "GET dashboard#index" do

        it "should get landing#login page if not logged in" do
          get '/dashboard'
          # expect redirect code
          expect(response).to have_http_status(302)
        end

      end
end
