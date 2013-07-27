require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Ogyam Odija", email: "test@ogyam.com",
                       password: "password", password_confirmation: "password") 
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:bio) }
  it { should respond_to(:image_url) }
  it { should respond_to(:location) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:goals) }
  it { should respond_to(:feed) }

  it { should be_valid }
  it { should_not be_admin }
  
  describe "accesible attributes" do
    it "should not allow access to admin" do
      expect do
        User.new(admin: "1")
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end     
  end

  describe "email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid } 
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      address = %w[user@foo,com user_at_foo.org example.user@foo.]
      address.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end 
    end
  end

  describe "when email addresss is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end 
    
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " } 
    it { should_not be_valid }
  end

  describe "when password does not match password confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid } 
  end

  describe "when password confirmation is nil" do
    pending "when password_confirmation is nil"
    before { @user.password_confirmation = nil }
    #it { should_not be_valid } 
  end

  describe "when password is too short" do
    pending "password is too short"
    before { @user.password = @user.password_confirmation = "a" * 6 }
    #it { should_not be_valid } 
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

     describe "with valid password" do
        it { should == found_user.authenticate(@user.password) } 
     end

     describe "with invalid password" do
        let(:user_for_invalid_password) { found_user.authenticate("invalid") }
        it { should_not == user_for_invalid_password }
        specify { user_for_invalid_password.should be_false }
     end
  end

  describe "remember_token" do
    before { @user.save }
    it "should have a nonblank remeber token" do
      subject.remember_token.should_not be_blank
    end 
  end

  describe "goals association" do
    
    before { @user.save }
    let!(:older_goal) do
      FactoryGirl.create(:goal, user: @user, created_at: 1.day.ago)
    end

    let!(:newer_goal) do
      FactoryGirl.create(:goal, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right order" do
      @user.goals.should == [newer_goal, older_goal]  
    end

    it "should destroy associated goals" do
      goals = @user.goals
      @user.destroy
      goals.each do |goal|
        Goal.find_by_id(goal.id).should be_nil
      end
    end

    describe "status feed" do
      let(:unfollowed_post) do
        FactoryGirl.create(:goal, user: FactoryGirl.create(:user))
      end

      its(:feed) { should include(newer_goal) }
      its(:feed) { should include(older_goal) }
      its(:feed) { should_not include(unfollowed_post) }
    end
  end
end
