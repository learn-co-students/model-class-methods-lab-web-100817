class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    order("id")
  end

  def self.longest
    name = Classification.joins(:boats).where("boats.length = ?", Boat.maximum("length"))
  end

end
