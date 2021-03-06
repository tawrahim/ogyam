require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Ben Malcom", email: "bob@gmail.com")
      FactoryGirl.create(:user, name: "Dave Thomas", email: "dave@me.com")
      visit users_path
    end

    it { should have_selector('title', text: 'All Users') }
    it { should have_selector('h1',    text: 'All Users') }

    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('li>a', text: user.name)
      end
    end

    describe "delete links" do
      it { should_not have_link('delete') }

      describe "as admin" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1) 
        end
        it { should_not have_link('delete', href: user_path(:admin)) }
      end
    end
  end

  describe "Signup page" do
    before { visit signup_path }

    it { should have_selector('title', text: full_title('Signup')) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:goal1) { FactoryGirl.create(:goal, user: user, content: "Foo")  }
    let!(:goal2) { FactoryGirl.create(:goal, user: user, content: "Foo bar baz")  }

    before { visit user_path(user) }

    it { should have_selector('title', text: user.name) }
    it { should have_selector('h3',    text: user.name) }

    describe "goals" do
      it { should have_content(goal1.content) }
      it { should have_content(goal2.content) }
      it { should have_content(user.goals.count) }
    end
  end

  describe "signup" do
    before { visit signup_path } 

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }
        
        it { should have_selector('title', text: 'Signup') }
        it { should have_content('error') }  
      end

    end

    describe "with valid information" do

      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@me.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      it "should send the user an email"

      describe "after saving a user"  do

        before { click_button submit }

        let(:user) { User.find_by_email("user@me.com") }

        it { should have_selector('title', text: user.name) }
        it { should have_link('Logout') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }   
    before do
      sign_in(user)
      visit edit_user_path(user)      
    end

    describe "page" do

      it { should have_selector('h1', text: "Update your profile") }
      it { should have_selector('title', text: "Edit User") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" } 
      
      it { should have_content('error') }  
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",              with: new_name
        fill_in "Email",             with: new_email 
        fill_in "Password",          with: user.password
        fill_in "Password confirmation", with: user.password
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_link('Logout', href: signout_path) }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end
