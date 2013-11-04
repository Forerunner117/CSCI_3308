class Tweet < ActiveRecord::Base
  attr_accessor :status
  belongs_to :zombie

end
