class Post < ApplicationRecord
    has_many :comments, :dependent => :delete_all
    default_scope { where("deleted IS FALSE") }
end
