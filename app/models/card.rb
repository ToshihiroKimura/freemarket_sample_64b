class Card < ApplicationRecord
  belongs_to :buyer, class_name: "User"
end
