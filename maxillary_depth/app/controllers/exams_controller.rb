class ExamsController < ApplicationController

  def index
    @exams = Exam.where(patient_id: params[:patient_id]).all
  end

  def show
    @exam = Exam.find(params[:id])
    
    respond_to do |format|
      format.html { render :show }
      format.js {render layout: false} 
    end
  end


  def edit
    @exam = Exam.find(params[:id])

    @exam.point_n_x = @exam.point_n.x
    @exam.point_n_y = @exam.point_n.y

    @exam.point_a_x = @exam.point_a.x 
    @exam.point_a_y = @exam.point_a.y

    @exam.point_po_x = @exam.point_po.x
    @exam.point_po_y = @exam.point_po.y

    @exam.point_or_x = @exam.point_or.x
    @exam.point_or_y = @exam.point_or.y

    respond_to do |format|
      format.html { render :edit }
      format.js {render layout: false} # Add this line to you respond_to block
    end
  end

  def update
    @exams = Exam.all

    patient_id = params[:patient_id]
    point_n_x = params[:exam][:point_n_x]
    point_n_y = params[:exam][:point_n_y]

    point_a_x = params[:exam][:point_a_x]
    point_a_y = params[:exam][:point_a_y]

    point_po_x = params[:exam][:point_po_x]
    point_po_y = params[:exam][:point_po_y]

    point_or_x = params[:exam][:point_or_x]
    point_or_y = params[:exam][:point_or_y]

    factory = RGeo::Cartesian.factory
    point_n = factory.point(point_n_x, point_n_y)
    point_a = factory.point(point_a_x, point_a_y)
    point_po = factory.point(point_po_x, point_po_y)
    point_or = factory.point(point_or_x, point_or_y)    
    
    @exam = Exam.find(params[:id])    
    @exam.patient_id = patient_id
    @exam.point_n = point_n
    @exam.point_a = point_a
    @exam.point_po = point_po
    @exam.point_or = point_or

    if @exam.save
      respond_to do |format|
        format.html { render :show, notice: 'Exam was successfully updated.' }
        format.js {render layout: false} 
      end
    else 
      respond_to do |format|
        format.html { render :show }
        format.js { render layout: false, errors: @exam.errors }
      end
    end
  end


    def create
      @exams = Exam.all
      
      patient_id = params[:patient_id]
      point_n_x = params[:exam][:point_n_x]
      point_n_y = params[:exam][:point_n_y]

      point_a_x = params[:exam][:point_a_x]
      point_a_y = params[:exam][:point_a_y]

      point_po_x = params[:exam][:point_po_x]
      point_po_y = params[:exam][:point_po_y]

      point_or_x = params[:exam][:point_or_x]
      point_or_y = params[:exam][:point_or_y]

      factory = RGeo::Cartesian.factory
      point_n = factory.point(point_n_x, point_n_y)
      point_a = factory.point(point_a_x, point_a_y)
      point_po = factory.point(point_po_x, point_po_y)
      point_or = factory.point(point_or_x, point_or_y)
        
      @exam = Exam.new
      @exam.patient_id = patient_id
      @exam.point_n = point_n
      @exam.point_a = point_a
      @exam.point_po = point_po
      @exam.point_or = point_or
      @exam.save

      respond_to do |format|
        format.html { redirect_to patients_path }
        format.js {render layout: false} 
      end           
    end
    
    def new        
        @exam = Exam.new
        @exam.patient_id = params[:patient_id]
        
        respond_to do |format|
          format.html { render :new }
          format.js {render layout: false} 
        end        
    end

    def destroy
      @exam = Exam.find(params[:id])
      @exam.destroy

      redirect_to patient_path(params[:patient_id])
    end

    private

    def exam_params
        parameters = params.require(:exam).permit(:id, :patient_id, :point_n_x, :point_n_y, :point_a_x, :point_a_y, :point_po_x, :point_po_y, :point_or_x, :point_or_y)
      end    
      
end
