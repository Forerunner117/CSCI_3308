class Zombie < ActiveRecord::Base
  attr_accessor :name, :brains
  validates :name, presence: true
  has_many :weapons
  has_many :tweets

  def initialize(attributes = nil)
    super(attributes)
    @name = 'Ash'
    tweets << Tweet.new
    tweets << Tweet.new
  end

end

