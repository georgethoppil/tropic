require 'rails_helper'
RSpec.describe UsersController, type: :controller do

  describe 'POST #create' do
    let(:valid_params) { { first_name: 'George', last_name: 'Thoppil', email: 'georgethoppil@george.com' } }
    let(:invalid_params) { { first_name: '', last_name: '', email: '' } }

    context 'with valid params' do
      it 'creates a new user' do
        expect {
          post :create, params: { user: valid_params, send_invitation: '1' }
        }.to change(User, :count).by(1)
      end

      it 'sends an email if send_invitation is true' do
        expect(EmailService).to receive(:send_email).with(valid_params[:email]).and_return(true)
        post :create, params: { user: valid_params, send_invitation: '1' }
      end
      #
      it 'sets a success message' do
        post :create, params: { user: valid_params, send_invitation: '1' }
        expect(flash[:notice]).to eq("Success! \n User created")
      end

      it 'redirects to the index page' do
        post :create, params: { user: valid_params, send_invitation: '1' }
        expect(response).to redirect_to(users_path)
      end
    end

    context "when EmailService raises an error" do
      it "doesn't create a new user and shows an alert message" do
        allow(EmailService).to receive(:send_email).and_raise("Error sending email").and_return(false)
        post :create, params: { user: valid_params, send_invitation: '1' }
        expect(response).to redirect_to(users_path)
        expect(flash[:alert]).to eq("User not created!")
        expect(User.count).to eq(0)
      end
    end

    context 'with invalid params' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: invalid_params, send_invitation: '0' }
        }.not_to change(User, :count)
      end

      it 'sets an error message' do
        post :create, params: { user: valid_params, send_invitation: '0' }
        expect(flash[:alert]).to eq("User not created!")
      end
    end
  end
end

