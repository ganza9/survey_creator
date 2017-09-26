class Survey < ActiveRecord::Base
  has_many(:question)
  validates(:name, {:presence => true, :uniqueness =>true})
  before_save(:capitalize)


private
  def capitalize
    name_array = self.name.split(" ")
    array = []
    name_array.each() do |name|
      array.push(name.capitalize())
    end
    self.name = array.join(" ")
  end
end
