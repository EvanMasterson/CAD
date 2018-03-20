class Patient < ApplicationRecord
    validates :email, uniqueness: true
    validates :firstName, :lastName, :dob, :address, :phone, :symptom, presence: true
end
