class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: [:classifications]).where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    self.joins(boats: [:classifications]).where("classifications.name = 'Sailboat'").uniq
  end

  def self.talented_seamen
    talented_seamen_array = self.joins(boats: [:classifications]).where("classifications.name = 'Sailboat'") & self.joins(boats: [:classifications]).where("classifications.name = 'Motorboat'")
    self.where(id: talented_seamen_array.collect(&:id))
  end

  def self.non_sailors
    sailors = self.joins(boats: [:classifications]).where("classifications.name = 'Sailboat'").uniq
    non_sailors_array = self.all - sailors
    self.where(id: non_sailors_array.collect(&:id))
  end
end
