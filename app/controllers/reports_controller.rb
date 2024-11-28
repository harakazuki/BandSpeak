class ReportsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @report = Report.new(
      reportable_type: params[:reportable_type],
      reportable_id: params[:reportable_id]
    )
  end
  
  def create
    reportable = find_reportable
    @report = reportable.reports.new(report_params)
    @report.user = current_user

    if @report.save
      redirect_back fallback_location: root_path, notice: '通報しました。'
    else
      redirect_back fallback_location: root_path, alert: '通報に失敗しました。'
    end
  end

  private

  def find_reportable
    Rails.logger.debug "Reportable Type: #{params[:reportable_type]}"
    Rails.logger.debug "Reportable ID: #{params[:reportable_id]}"
    params[:reportable_type].constantize.find(params[:reportable_id])
  end
end
