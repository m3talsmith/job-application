require 'rubygems'
require 'factory_girl'
require 'factories'
require 'spec'
require 'spec/autorun'
require 'redgreen'
require 'user_profile'
require 'helper'
require 'user'
require 'photo'

describe "Helper" do
  before(:each) do
    @helper = Helper.new
  end
  describe "display_photo" do
    it "should return the wrench if there is no profile" do
      @helper.display_photo(nil, "100x100", {}, {}, true).should == "<img src='wrench.png' />"
    end
        
    describe "With a profile, user and photo requesting a link" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
        @user    = User.new
        @profile.user = @user
        @photo   = Photo.new
        @user.photo = @photo
        @profile.stub!(:has_valid_photo?).and_return(true)
      end
      it "should return a link" do
        @helper.display_photo(@profile, "100x100", {}, {}, true).should == "<a href='/profiles/#{@profile.name}/'><img src='/assets/user/photo_100x100.png' class='thumbnail' size='100x100' title='Link to #{@profile.name}' /></a>"
      end
    end
    
    describe "With a profile, user and photo not requesting a link" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
        @user    = User.new
        @profile.user = @user
        @photo   = Photo.new
        @user.photo = @photo
        @profile.stub!(:has_valid_photo?).and_return(true)
      end
      it "should return an image" do
        @helper.display_photo(@profile, "100x100", {}, {}, false).should == "<img src='/assets/user/photo_100x100.png' class='thumbnail' size='100x100' title='Link to #{@profile.name}' />"
      end
    end
    
    describe "Without a user, but requesting a link" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
      end
      it "return a default image" do
        @helper.display_photo(@profile, "100x100", {}, {}, true).should == "<a href='/profiles/#{@profile.name}/'><img src='user100x100.jpg' /></a>"
      end
    end
    
    describe "When the user doesn't have a photo" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
        @user    = User.new
        @profile.user = @user
        @profile.stub!(:has_valid_photo?).and_return(false)
      end
      describe "As a representative user" do
        before(:each) do
          @user.stub!(:rep?).and_return(true)
        end
        it "return a default link" do
          @helper.display_photo(@profile, "100x100", {}, {}, true).should == "<a href='/profiles/#{@profile.name}/'><img src='user190x119.jpg' /></a>"
        end
        
      end
      
      describe "As a regular user" do
        before(:each) do
          @user.stub!(:rep?).and_return(false)
        end
        it "return a default link" do
          @helper.display_photo(@profile, "100x100", {}, {}, true).should == "<a href='/profiles/#{@profile.name}/'><img src='user100x100.jpg' /></a>"
        end
      end
    end
    
    describe "When the user doesn't have a photo and we don't want to display the default photo" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
        @user    = User.new
        @profile.user = @user
        @profile.stub!(:has_valid_photo?).and_return(false)
      end
      describe "As a representative user" do
        before(:each) do
          @user.stub!(:rep?).and_return(true)
        end
        it "return a default link" do
          @helper.display_photo(@profile, "100x100", {}, {:show_default => false}, true).should == "<a href='/profiles/#{@profile.name}/'>#{@profile.name}</a>"
        end
        
      end
      
      describe "As a regular user" do
        before(:each) do
          @user.stub!(:rep?).and_return(false)
        end
        it "return a default link" do
          @helper.display_photo(@profile, "100x100", {}, {:show_default => false}, true).should == "<a href='/profiles/#{@profile.name}/'>#{@profile.name}</a>"
        end
      end
    end
    
    
  end
end