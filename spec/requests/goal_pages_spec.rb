require 'spec_helper'

describe "Goal Pages" do
  
  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  before { sign_in user }

  describe "creation of a new goal" do
    before { visit root_path }

    describe "with invalid information" do
      
      it "should not create goal" do
        expect { click_button "Post" }.not_to change(Goal, :count)   
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end
  end

  describe "deleting goals" do
    before { FactoryGirl.create(:goal, user: user) }

    describe "as correct_user" do
      before { visit root_path }

      it "should delete goal" do
        expect { click_link "delete" }.to change(Goal, :count).by(-1)
      end
    end
  end
end
