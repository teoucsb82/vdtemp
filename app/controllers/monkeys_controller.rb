class MonkeysController < ApplicationController
  before_action :set_monkey, only: [:show, :edit, :update, :destroy]

  # GET /monkeys
  # GET /monkeys.json
  def index
    @monkeys = Monkey.all
  end

  # GET /monkeys/1
  # GET /monkeys/1.json
  def show
  end

  # GET /monkeys/new
  def new
    @monkey = Monkey.new
  end

  # GET /monkeys/1/edit
  def edit
  end

  # POST /monkeys
  # POST /monkeys.json
  def create
    @monkey = Monkey.new(monkey_params)

    respond_to do |format|
      if @monkey.save
        format.html { redirect_to @monkey, notice: 'Monkey was successfully created.' }
        format.json { render action: 'show', status: :created, location: @monkey }
      else
        format.html { render action: 'new' }
        format.json { render json: @monkey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /monkeys/1
  # PATCH/PUT /monkeys/1.json
  def update
    respond_to do |format|
      if @monkey.update(monkey_params)
        format.html { redirect_to @monkey, notice: 'Monkey was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @monkey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monkeys/1
  # DELETE /monkeys/1.json
  def destroy
    @monkey.destroy
    respond_to do |format|
      format.html { redirect_to monkeys_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monkey
      @monkey = Monkey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monkey_params
      params[:monkey]
    end
end
