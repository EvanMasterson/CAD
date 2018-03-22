class Doctor < ApplicationRecord
    has_many :patients
    validates :email, presence: true, uniqueness: true
end
