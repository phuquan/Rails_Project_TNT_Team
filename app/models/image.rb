class Image < ActiveRecord::Base
    has_many :tags
    has_many :comments
    belongs_to :user
end
