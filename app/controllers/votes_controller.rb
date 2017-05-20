class VotesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    project.liked_by(current_user)
    render json: project.votes_for.count
  end

  def destroy
    project.unliked_by current_user
    render json: project.votes_for.count
  end

  private

  def project
    Project.find(params[:project_id])
  end
end
