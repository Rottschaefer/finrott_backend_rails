class Transaction < ApplicationRecord
    belongs_to :user
    belongs_to :account, primary_key: 'pluggy_id', foreign_key: 'account_pluggy_id'
  
    validates_presence_of :pluggy_id, :user_id, :description, :currency_code, :amount, :date, :category, :category_id, :account_pluggy_id, :status, :transaction_type, :merchant_business_name, :merchant_category, :user_id
 
    validates :amount, numericality: true
  

  end
  
