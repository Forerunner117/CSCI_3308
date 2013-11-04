require 'spec_helper'

describe Zombie do
  #it "should have tweets" do
  #  tweet1 = Tweet.new
  #  tweet2 = Tweet.new
  #  zombie = Zombie.new(name: 'Ash', tweets: [tweet1, tweet2])
  #end

  its(:name) { should == 'Ash' }
  its(:brains) { should be_nil }
  its('tweets.size') { should == 2 }
end
