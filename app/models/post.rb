class Post < ApplicationRecord
    has_many :comments, -> {order('updated_at DESC')}, :dependent => :delete_all
    default_scope { where("deleted IS FALSE") }
end
