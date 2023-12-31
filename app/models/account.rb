class Account < ApplicationRecord
    belongs_to :user
    validates_presence_of :pluggy_id, :item_id, :user_id 
    #, :transfer_number, :bank_name, :name, :balance 
end
