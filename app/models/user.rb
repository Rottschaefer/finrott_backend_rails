class User < ApplicationRecord 
    before_save {self.email = email.downcase}
    has_many :accounts
    has_many :items
    has_many :transactions
    has_many :fixed_transactions
    validates :name, 
        presence: true,
        length: {minimum: 2}

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,
        presence: true,
        uniqueness: {case_sensitive: false},
        format: {with: VALID_EMAIL_REGEX}

    has_secure_password

end