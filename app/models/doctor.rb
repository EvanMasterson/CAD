class Doctor < ApplicationRecord
    has_many :patients
    validates :firstName, :lastName, :clinic, :specialisation, presence: true
end
