class Image < ActiveRecord::Base
    mount_uploader :url, ImageUploader
    has_many :tags
    has_many :comments, :dependent => :destroy
    belongs_to :user
end
