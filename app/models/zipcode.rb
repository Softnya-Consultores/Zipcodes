class Zipcode < ApplicationRecord
    validates :zipcode, presence: true
end
