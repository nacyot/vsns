require 'spec_helper'

describe User do
  before(:each) do
    @attr = { 
      :username => "Example User",
      :email => "user@example.com",
      :password => "12345678",
      :password_confirmation => "12345678"
    }
  end	

  context 'about email' do 

	  it "should create a new instance given a valid attribute" do
	    User.create!(@attr)
	  end

	  it "should require an email address" do
	    no_email_user = User.new(@attr.merge(:email => ""))
	    no_email_user.should_not be_valid
	  end

  end

  context "passwords" do

    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end

  context "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
     end

  end
end
