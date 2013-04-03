class AddressbooksController < ApplicationController
  # GET /addressbooks
  # GET /addressbooks.json
  def index
    @addressbooks = Addressbook.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @addressbooks }
    end
  end

  # GET /addressbooks/1
  # GET /addressbooks/1.json
  def show
    @addressbook = Addressbook.find(params[:id])
    @page_title = @addressbook.name
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @addressbook }
      end
  end

  # GET /addressbooks/new
  # GET /addressbooks/new.json
  def new
    @addressbook = Addressbook.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @addressbook }
    end
  end

  # GET /addressbooks/1/edit
  def edit
    @addressbook = Addressbook.find(params[:id])
  end

  # POST /addressbooks
  # POST /addressbooks.json
  def create
    @addressbook = Addressbook.new(params[:addressbook])

    respond_to do |format|
      if @addressbook.save
        format.html { redirect_to @addressbook, notice: 'Addressbook was successfully created.' }
        format.json { render json: @addressbook, status: :created, location: @addressbook }
      else
        format.html { render action: "new" }
        format.json { render json: @addressbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /addressbooks/1
  # PUT /addressbooks/1.json
  def update
    @addressbook = Addressbook.find(params[:id])

    respond_to do |format|
      if @addressbook.update_attributes(params[:addressbook])
        format.html { redirect_to @addressbook, notice: 'Addressbook was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @addressbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addressbooks/1
  # DELETE /addressbooks/1.json
  def destroy
    @addressbook = Addressbook.find(params[:id])
    @addressbook.destroy

    respond_to do |format|
      format.html { redirect_to addressbooks_url }
      format.json { head :no_content }
    end
  end
end
