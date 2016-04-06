class Tag < ActiveRecord::Base
    has_many :image_tags
end
