class VotesController < ApplicationController

  def index
    render json: project_vote_count
  end

  def create
    project.liked_by(current_user)
  end

  def destory
    project.unliked_by current_user
  end

  private

  def project
    Project.find(params[:project_id])
  end

  def project_vote_count
    project.votes_for.size
  end
end
