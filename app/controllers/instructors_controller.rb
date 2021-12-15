class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
#   rescue_from ActiveRecord::NoMethodError, with: :render_no_method

  def index
    render json: Instructor.all, status: :ok
  end

  def show
    instructor = find_instructor
    render json: instructor, status: :ok
  end

  def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created
  end

  def update
    instructor = find_instructor
    instructor.update!(instructor_params)
    render json: instructor, status: :ok
end

  def destroy
    instructor = find_instructor
    instructor.destroy
    render json: { messages: "#{instructor.name} file has been deleted" }
end

  private

  def render_not_found
    render json: { error: 'Instructor not found' }, status: :not_found
  end

  def render_invalid(invalid)
    render json: {
             error: invalid.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end

  def find_instructor
    Instructor.find(params[:id])
  end

  def instructor_params
    params.permit(:name)
  end
  def render_no_method
    render json: { error: 'try again' }, status: :unprocessable_entity
  end
end
