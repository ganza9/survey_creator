class Opinion < ActiveRecord::Base
  belongs_to(:question)
end
