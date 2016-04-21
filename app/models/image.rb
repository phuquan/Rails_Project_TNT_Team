class Image < ActiveRecord::Base
    mount_uploader :url, ImageUploader
    has_many :tags
    has_many :comments
    belongs_to :user
	
    public 
	def search(query, user_id) 
		Image.where("name LIKE ? and user_id = ?", "%#{query}%", "#{user_id}")
	end
end
