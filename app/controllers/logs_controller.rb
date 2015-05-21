class LogsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @log = Log.new
  end

  def create
    @project = Project.find(params[:project_id])
    @log = Log.new(log_params)
    @log.account = current_account
    @log.project = @project

    if @log.save
      redirect_to root_path
    else
      render :new
    end
  end

  def log_params
    params.require(:log).permit(:quality, :amount, :worked_at, :do_not_bill)
  end
  private "log_params"
end
