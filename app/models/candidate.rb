class Candidate < ApplicationRecord
	has_many :votes
  validates :name, presence: true, uniqueness: true
  validates :party, presence: true

  def display_gender
    if gender == "1"
      "#{name} 先生"
    elsif gender == "2"
      "#{name} 女士"
    else
      name
    end
  end
  
end