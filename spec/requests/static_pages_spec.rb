require 'spec_helper'

describe "Static Pages" do

  subject { page }

  describe "Home Page" do
    before { visit root_path} 

    it { should have_selector('title', text: full_title('')) }
  end

  describe "About Page" do
    before { visit about_path }

    it { should have_selector('title', text: full_title('About Us')) }
  end

  describe "Terms Page" do
    before { visit terms_path} 

    it { should have_selector('title', text: full_title('Terms')) }
  end


  describe "Help Page" do
    before { visit help_path} 

    it { should have_selector('title', text: full_title('Help')) }
  end

  describe "Blog Page" do
    before { visit blog_path} 

    it { should have_selector('title', text: full_title('Blog')) }
  end

  it "should have the right links on the layout" do
    visit root_path

    click_link "About"
    page.should have_selector('title', text: full_title('About Us'))
  end
end
