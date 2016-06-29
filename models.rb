class User < ActiveRecord::Base
	belongs_to :profile
	has_many :posts
end

class Profile < ActiveRecord::Base
	belongs_to :user 
end

class Post < ActiveRecord::Base
	belongs_to :user
end



