require 'spec_helper'

describe "UserPages" do
  subject { page } 

  describe "signup page" do
    
    before { visit signup_path }

    let(:submit) { "Create my account" }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Sign up') }
        it { should have_content('error') }
        it { should have_content("* Password can't be blank") }
        it { should have_content("* Name can't be blank") }
        it { should have_content("* Email can't be blank") }
        it { should have_content("* Email is invalid") }
        it { should have_content("* Password is too short") }
        it { should have_content("* Password confirmation can't be blank") }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end


  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',   text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
end
