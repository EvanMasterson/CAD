class Patient < ApplicationRecord
    validates :email, uniqueness: true
end
