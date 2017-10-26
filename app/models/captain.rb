class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    boats = Boat.joins(:classifications).where('classifications.name = "Catamaran"').map {|boat| boat.captain_id}
    Captain.where(id: boats)
  end

  def self.sailors
      boats = Boat.joins(:classifications).where('classifications.name = "Sailboat"').map {|boat| boat.captain_id}
      Captain.where(id: boats)
    end

  def self.talented_seamen
    boats = Boat.joins(:classifications).where('classifications.name = "Motorboat"').map {|boat| boat.captain_id}
    boats2 = Boat.joins(:classifications).where('classifications.name = "Sailboat"').map {|boat| boat.captain_id}
    array = []
    boats.each do |boat|
      if boats2.include?(boat)
        array << boat
      end
    end
    Captain.where(id: array)
  end

  def self.non_sailors
    # captain ids: [8323, 8324, 8325, 8326, 8327, 8328, nil]
      #  expected: ["William Kyd", "Arel English", "Henry Hudson"]
      #       got: ["Captain Cook", "Captain Kidd", "William Kyd", "Arel English", "Henry Hudson", "Samuel Axe"]
    sailboat_captains = Boat.joins(:classifications).where('classifications.name = "Sailboat"').map {|boat| boat.captain_id}
    Captain.where.not(id: sailboat_captains)
  end

  def self.my_all
      Boat.joins(:classifications).map {|classif| classif.name}
  end
end
