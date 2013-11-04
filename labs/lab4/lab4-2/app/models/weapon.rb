class Weapon < ActiveRecord::Base
  attr_accessor :name
  belongs_to :zombie
end
