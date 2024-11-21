class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @reports = Report.includes(:user, :reportable).order(created_at: :desc).page(params[:page])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(status: params[:status])
      redirect_to admin_reports_path, notice: '通報ステータスを更新しました。'
    else
      redirect_to admin_reports_path, alert: '更新に失敗しました。'
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to admin_reports_path, notice: '通報を削除しました。'
  end
end
