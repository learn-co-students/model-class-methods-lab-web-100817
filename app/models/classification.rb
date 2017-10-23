class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    self.where("id IN (?)", BoatClassification.longest_boat_classification_ids)
  end

end
