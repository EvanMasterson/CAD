class Patient < ApplicationRecord
    belongs_to :doctor, optional: true
    validates :email, uniqueness: true
    validates :firstName, :lastName, :dob, :address, :phone, :symptom, presence: true
end
