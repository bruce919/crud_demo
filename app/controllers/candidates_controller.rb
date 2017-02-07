class CandidatesController < ApplicationController

before_action :find_candidate, only: [:show, :edit, :update, :destroy, :vote] #每個方法執行前就先執行這個方法
skip_before_filter :verify_authenticity_token

	def index
		# render json:  Candidate.all
		@candidates = Candidate.all
		@text = "我是XXX，我當選之後，一定會。。。。。。"
	end

	def new
		@candidate = Candidate.new
	end

	def create
		#確認只有這幾個資料可以進資料庫
		# clean_params = params.require(:candidate).permit(:name, :gender, :age, :party) 
		
		@candidate = Candidate.new(candidate_params)
		
		if @candidate.save
			flash[:notice] = "新增成功"
			redirect_to candidates_path
		else
			render :new #是 new.html.erb，而不是 new 的方法
		end

	end

	def edit
		@candidate = Candidate.find_by(id: params[:id])

		if not @candidate #if not 也可寫成 unless
			# flash[:notice] = "查無此資料" 可以把這行寫成這方式
			redirect_to candidates_path, notice: "查無此資料"
			#上面也可以全部寫成一行 redirect_to candidates_path, notice: "查無此資料" unless @candidate
		end
	end

	def update
			# @candidate = Candidate.find_by(id: params[:id]) 底下加  private 的 find_candidate就不用寫這行
			# redirect_to candidates_path, notice: "查無此資料" unless @candidate 底下加  private 的 find_candidate就不用寫這行
		# find_candidate 有加 before_action 就可以不用寫這行


		if @candidate.update_attributes(candidate_params)
			redirect_to candidates_path, notice: "#{@candidate.name}更新成功!"
		else
			  :edit #是指 edit.html.erb
		end

	end

	def destroy
			# @candidate = Candidate.find_by(id: params[:id]) 底下加  private 的 find_candidate就不用寫這行
			# redirect_to candidates_path, notice: "查無此資料" unless @candidate 底下加  private 的 find_candidate就不用寫這行
		# find_candidate 有加 before_action 就可以不用寫這行

		@candidate.destroy
		redirect_to candidates_path, notice: "刪除成功！"
	end

	# api :GET, '/age/:id'
	# param :id, :number
	def show
			# @candidate = Candidate.find_by(id: params[:id]) 底下加  private 的 find_candidate就不用寫這行
			# redirect_to candidates_path, notice: "查無此資料" unless @candidate 底下加  private 的 find_candidate就不用寫這行
		# find_candidate 有加 before_action 就可以不用寫這行
	end

	def vote
		@candidate.votes.create(ip_address: request.remote_ip)
		
		#寄信
		VoteMailer.notify(@candidate).deliver_later #deliver_now 是指馬上寄

		redirect_to candidates_path, notice:"投票成功！"

	end

	private
	def find_candidate
		@candidate = Candidate.find_by(id: params[:id])
		redirect_to candidates_path, notice: "查無此資料" unless @candidate
	end

	def candidate_params
		params.require(:candidate).permit(:name, :gender, :age, :party)
	end


end