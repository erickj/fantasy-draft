class Player < ActiveRecord::Base
  belongs_to :pro_team

  alias :team :pro_team

  class << self
    def sort_by_name(list)
      list.sort do |x,y|
        x.reverse_name <=> y.reverse_name
      end
    end
  end

  def reverse_name
    person_pattern = /^([^\s]*)[\s]+(.*)$/
    defense_pattern = /(.*)D\/ST$/
 
    case name
    when defense_pattern
      name
    when person_pattern
      "%s, %s"%[$2, $1]
    else
      name
    end
  end
end
