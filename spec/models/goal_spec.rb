require 'spec_helper'

describe Goal do

  let(:user) { FactoryGirl.create(:user) }

  before do
    @goal = user.goals.build(content: "I wanna be successful")
  end
  
  subject { @goal }
  
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
  
  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Goal.new(user_id: "1")
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when the user id is not present" do
    before { @goal.user_id = nil }
    it { should_not be_valid } 
  end

  describe "when the goal is blank" do
    before { @goal.content = " " }
    it { should_not be_valid }
  end

  describe "when content of goal is too long" do
    before { @goal.content = "a" * 141 }
    it { should_not be_valid }
  end
end
