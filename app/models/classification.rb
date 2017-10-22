class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    max_length = Boat.maximum("length")
    max_boat = Boat.find_by(length: max_length)
    max_boat.classifications
  end
end
