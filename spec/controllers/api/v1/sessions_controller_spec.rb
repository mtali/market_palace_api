require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe "POST #create" do
    before(:each) do
      @user = FactoryGirl.create :user
    end

    context "when the creditials are correct" do
      before(:each) do
        creditials = { email: @user.email, password: "12345678" }
        post :create, params: { session: creditials }
      end

      it "return the user record corresponding to a given creditials" do
        @user.reload
        expect(json_response[:data][:attributes][:'auth-token']).to eql @user.auth_token
      end

      it { should respond_with 200 }
    end


    context "when creditials are incorrect" do
      before(:each) do
        creditials = { email: @user.email, password: "invalidpassword" }
        post :create, params: { session: creditials }
      end

      it "return json with an error" do
        expect(json_response[:errors]).to eql "Invalid email or password"
      end

      it { should respond_with 422 }
    end

  end



  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      sign_in @user
      delete :destroy, params: { id: @user.auth_token }
    end

    it { should respond_with 204 }
  end
end
