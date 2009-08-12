class ProTeam < ActiveRecord::Base
  has_many :players

  def to_s
    "%s %s"%[self.city,self.name]
  end 
end
