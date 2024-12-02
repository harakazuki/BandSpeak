class ReportsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @report = Report.new
    @report.reportable_type = params[:reportable_type]
    @report.reportable_id = params[:reportable_id]
  end
  
  def create
    @report = Report.new(report_params)
    if @report.save
      Rails.logger.info "Report saved successfully: #{@report.inspect}"
      redirect_to @report.reportable, notice: '通報を送信しました。'
    else
      Rails.logger.error "Failed to save report: #{@report.errors.full_messages}"
      render :new, status: :unprocessable_entity
    end
  end



  private
  def find_reportable
    if params[:report].present? && params[:report][:reportable_type].present? && params[:report][:reportable_id].present?
      params[:report][:reportable_type].constantize.find(params[:report][:reportable_id])
    else
      Rails.logger.error "Missing reportable_type or reportable_id: #{params.inspect}" # エラー情報をログに記録
      raise ArgumentError, "Invalid parameters: reportable_type or reportable_id is missing"
    end
  end


  def report_params
    params.require(:report).permit(:reason, :reportable_type, :reportable_id)
  end
end
