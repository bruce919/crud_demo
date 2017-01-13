class Candidate < ApplicationRecord
	validates :name, :party, presence: true
end
