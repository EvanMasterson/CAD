class Patient < ApplicationRecord
    belongs_to :doctor, :user
end
