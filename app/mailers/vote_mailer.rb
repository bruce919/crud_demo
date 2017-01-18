class VoteMailer < ApplicationMailer


def notify(candidate)
	@candidate = candidate
	mail to: 'bruce919@gmail.com', subject:'投票'
end



end
