require 'rails_helper'

RSpec.describe "Landings", type: :request do
    describe "GET landing#login" do
        it "should get loging page" do
          get '/'
          expect(response).to have_http_status(200)
        end
      end
end
