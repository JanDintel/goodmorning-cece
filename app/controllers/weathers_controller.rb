class WeathersController < ApplicationController
  # GET /weathers
  # GET /weathers.json
  def index
    @weathers = Weather.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weathers }
    end
  end

  # GET /weathers/1
  # GET /weathers/1.json
  def show
    @weather = Weather.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @weather }
    end
  end

  # GET /weathers/new
  # GET /weathers/new.json
  def new
    @weather = Weather.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @weather }
    end
  end

  # GET /weathers/1/edit
  def edit
    @weather = Weather.find(params[:id])
  end

  # POST /weathers
  # POST /weathers.json
  def create
    @weather = Weather.new(params[:weather])

    respond_to do |format|
      if @weather.save
        format.html { redirect_to @weather, notice: 'Weather was successfully created.' }
        format.json { render json: @weather, status: :created, location: @weather }
      else
        format.html { render action: "new" }
        format.json { render json: @weather.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /weathers/1
  # PUT /weathers/1.json
  def update
    @weather = Weather.find(params[:id])

    respond_to do |format|
      if @weather.update_attributes(params[:weather])
        format.html { redirect_to @weather, notice: 'Weather was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @weather.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weathers/1
  # DELETE /weathers/1.json
  def destroy
    @weather = Weather.find(params[:id])
    @weather.destroy

    respond_to do |format|
      format.html { redirect_to weathers_url }
      format.json { head :no_content }
    end
  end
end
