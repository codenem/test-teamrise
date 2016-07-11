class ObjectivesController < ApplicationController
  before_action :root_objectives, only: :index

  def index
    render locals: {
      level: search_params[:level]
    }
  end

  private

  def search_params
    params.permit(:team_id, :level)
  end

  def root_objectives
    @root_objectives = search_params[:team_id].present? ? Team.find(search_params[:team_id]).root_objectives : Objective.roots
  end
end
