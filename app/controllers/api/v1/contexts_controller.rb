class Api::V1::ContextsController < ApplicationController
  before_action :set_context, only: %i[ show update destroy ]

  # GET /contexts
  def index
    @contexts = Context.all

    render json: @contexts
  end

  # GET /contexts/1
  def show
    render json: @context
  end

  # POST /contexts
  def create
    @context = Context.new(context_params)

    if @context.save
      render json: @context, status: :created, location: @context
    else
      render json: @context.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contexts/1
  def update
    if @context.update(context_params)
      render json: @context
    else
      render json: @context.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contexts/1
  def destroy
    @context.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_context
      @context = Context.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def context_params
      params.fetch(:context, {})
    end
end
