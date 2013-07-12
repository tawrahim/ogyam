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
  it { should respond_to(:authenticate) }

  it { should be_valid }
   
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
end
