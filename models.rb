class User < ActiveRecord::Base
	has_one :profile, dependent: :destroy
	has_many :posts, dependent: :destroy

end

class Profile < ActiveRecord::Base
	belongs_to :user 

end

class Post < ActiveRecord::Base
	belongs_to :user 
end



