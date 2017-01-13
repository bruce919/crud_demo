class CandidatesController < ApplicationController

	def index
		@candidates = Candidate.all
	end

	def new
		@candidate = Candidate.new
	end

	def create
		clean_params = params.require(:candidate).permit(:name, :gender, :age, :party)
		
		@candidate = Candidate.new(clean_params)
		
		if @candidate.save
			flash[:notice] = "新增成功"
			redirect_to candidates_path
		else
			render :new #借new.html.erb，而不是 new 的方法
		end

	end

	def edit
		@candidate = Candidate.find_by(id: params[:id])

		if not @candidate #if not 也可寫成 unless
			# flash[:notice] = "查無此資料" 可以把這行寫成這方式
			redirect_to candidates_path, notice: "查無此資料"
			#也可以全部寫成一行 redirect_to candidates_path, notice: "查無此資料" unless @candidate
		end
	end

	def update
		@candidate = Candidate.find_by(id: params[:id])
		# redirect_to candidates_path, notice: "查無此資料" unless @candidates
		
		clean_params = params.require(:candidate).permit(:name, :gender, :age, :party)

		if @candidate.update_attributes(clean_params)
			redirect_to candidates_path, notice: "#{@candidate.name}更新成功!"
		else
			render :edit #是指 edit.html.erb
		end

	end

end