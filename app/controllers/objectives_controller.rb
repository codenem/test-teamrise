class ObjectivesController < ApplicationController
  before_action :root_objectives, only: :index

  def index
    render locals: {
      filters: {
        level: search_params[:level],
        done: search_params[:done] == '' ? nil : search_params[:done] == 'true'
      }
    }
  end

  private

  def search_params
    params.permit(:team_id, :level, :done)
  end

  def root_objectives
    @root_objectives = search_params[:team_id].present? ? Team.find(search_params[:team_id]).root_objectives : Objective.roots
  end
end
