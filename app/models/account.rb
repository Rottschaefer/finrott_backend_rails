class Account < ApplicationRecord
    belongs_to :user
    has_many :transactions, primary_key: 'pluggy_id', foreign_key: 'account_pluggy_id'
    validates_presence_of :pluggy_id, :item_id, :user_id 
    validates :pluggy_id, uniqueness: true
    #, :transfer_number, :bank_name, :name, :balance 
end
