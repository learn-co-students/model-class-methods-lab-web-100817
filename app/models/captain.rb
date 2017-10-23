class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.where("id IN (?)", Boat.catamaran_captains)
  end

  def self.sailors
    captain_ids = Boat.sailboats.map {|x| x.captain_id}.compact.uniq
    self.where("id IN (?)", captain_ids)
  end

  def self.talented_seamen
    ids = Boat.seamen_captains
    self.where("id IN (?)", ids)
  end

  def self.non_sailors
    captain_ids = Boat.sailboats.map {|x| x.captain_id}.compact.uniq
    self.where("id NOT IN (?)", captain_ids)
  end
end
