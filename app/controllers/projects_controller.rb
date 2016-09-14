class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  def index
    @projects = Project.all

    render json: @projects
  end

  def show
    render json: @project
  end

  def create
    @project = Project.new(project_params)
    @project.contacts = relationship_params[:contacts] || []
    @project.offers = relationship_params[:offers] || []
    @project.tasks = relationship_params[:tasks] || []

    if @project.save
      render json: @project, status: :created, location: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      @project.contacts = relationship_params[:contacts] if relationship_params[:contacts]
      @project.offers = relationship_params[:offers] if relationship_params[:offers]
      @project.tasks = relationship_params[:tasks] if relationship_params[:tasks]
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:data).require(:attributes).permit(:name, :status)
  end
end
