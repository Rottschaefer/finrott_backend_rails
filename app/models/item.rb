class Item < ApplicationRecord
    belongs_to :user
    validates_presence_of :pluggy_id
    validates :pluggy_id,  uniqueness: true

end
