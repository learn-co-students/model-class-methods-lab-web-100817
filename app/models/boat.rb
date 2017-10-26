require 'pry'

class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def self.first_five
    Boat.all.order("id").limit(5)
  end

  def self.dinghy
    Boat.where("length < 20")
  end

  def self.ship
    Boat.where("length >20")
  end

  def self.last_three_alphabetically
    Boat.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    Boat.where(captain: nil)
  end

    def self.sailboats
# Author.joins("INNER JOIN posts ON posts.author_id = authors.id AND posts.published = 't'")
      Boat.joins(:classifications).where('classifications.name = "Sailboat"')
    end

    def self.with_three_classifications
      # boats = BoatClassification.group(:boat_id).count.select {|key, value| value == 3}.keys
      # boat = Boat.find(boats)
     boats = BoatClassification.group(:boat_id).count.select {|key, value| value == 3}.keys
     name = Boat.where(id: boats)
    end



end

# Pry.start
