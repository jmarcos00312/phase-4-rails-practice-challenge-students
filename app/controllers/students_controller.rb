class StudentsController < ApplicationController
 rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
  rescue_from ActionController::ParameterMissing, with: :render_no_method

  def index
    render json: Student.all, status: :ok
  end

  def show
    student = find_student
    render json: student, status: :ok
  end

  def create
    student = Student.create!(student_params)
    render json: student, status: :created
  end

  def update
    student = find_student
    student.update!(student_params)
    render json: student, status: :ok
end

  def destroy
    student = find_student
    student.destroy
    render json: { messages: "#{student.name} file has been deleted" }
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

  def find_student
    Student.find(params[:id])
  end

  def student_params
    params.permit(:name, :age, :instructor_id)
  end
  def render_no_method
    render json: { error: 'missing something' }, status: :unprocessable_entity
  end
end
