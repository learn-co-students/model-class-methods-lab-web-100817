require 'pry'

class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.order("id").limit(5)
  end

  def self.dinghy
    Boat.where("length < 20")
  end

  def self.ship
    Boat.where("length > 20")
  end

  def self.last_three_alphabetically
    Boat.order('name desc').limit(3)
  end

  def self.without_a_captain
    Boat.where(captain_id: nil)
  end

  def self.sailboats
    Boat.joins(:classifications).where('classifications.name = "Sailboat"')
  end

  def self.with_three_classifications
    Boat.where('id IN (?)', self.ids_of_three)
  end

  def self.ids_of_three
    Boat.all.inject([]) do |memo, boat|
      memo << boat.id if boat.classifications.length == 3
      memo
    end
  end

  def self.longest_boat_id
    Boat.order("length DESC").first.id
  end

  def self.catamaran_captains
    Boat.joins(:classifications).where('classifications.name = "Catamaran"').map {|x| x.captain_id}
  end

  def self.seamen_captains
    motorboats = Boat.joins(:classifications).where("classifications.name" => "Motorboat").map {|x| x.captain_id}.compact.uniq
    sailboats = Boat.joins(:classifications).where("classifications.name" => "Sailboat").map {|x| x.captain_id}.compact.uniq
    motorboats.select {|x| sailboats.include?(x)}
  end

end
