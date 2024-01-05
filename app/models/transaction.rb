class Transaction < ApplicationRecord
    belongs_to :user
    belongs_to :account, primary_key: 'pluggy_id', foreign_key: 'account_pluggy_id'
  
    validates_presence_of :pluggy_id, :user_id, :description, :currency_code, :amount, :date, :account_pluggy_id, :status, :transaction_type, :user_id
 
    validates :amount, numericality: true
    validates :pluggy_id, uniqueness: true
  

  end
  
