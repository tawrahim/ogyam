require 'spec_helper'

describe Motivation do

  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }

  before do
    @motivation = user.motivations.build(content: "You can do this")
    @motivation.motivated_user = user2.id
  end

  subject { @motivation }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:motivated_user) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }
  
  describe "accesible attributes" do
    it "should not allow access to motivated_user and user_id" do
      expect do
        Motivation.new(user_id: "1", motivated_user: "22")
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when motivator and user_id is not preset" do
    before  do
      @motivation.user_id = nil
      @motivation.motivated_user = nil
    end
    it { should_not be_valid }
  end

  describe "when the motivation is blank" do
    before { @motivation.content = " " }
    it { should_not be_valid }
  end
end
