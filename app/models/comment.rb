class Comment < ApplicationRecord
  belongs_to :post 
  default_scope { where("deleted IS FALSE") }
  
end
