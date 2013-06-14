class Birthday < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :date, :name, :facebook_id
end
