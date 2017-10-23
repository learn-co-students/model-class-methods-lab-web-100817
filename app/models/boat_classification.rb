class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

  def self.longest_boat_classification_ids
    longest = Boat.longest_boat_id
    self.where(:boat_id => longest).map {|x| x.classification_id}
  end

end
