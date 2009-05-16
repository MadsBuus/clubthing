class ClientsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:auto_complete_for_client_name]

  def auto_complete_for_client_name
    @pattern = params[:client][:name].split
    @matches = Client.find(:all, :include => :accounts, :conditions => ['name like ?', "%#{@pattern.first}%"])
    render :layout => false
  end

  # GET /clients
  # GET /clients.xml
  def index
    if(params[:client])
      client = Client.find_by_name(params[:client][:name])
      if client
        redirect_to(client)
      else
        flash[:notice] = 'No client found'        
        redirect_to(clients_path)
      end
      return
    end
    @clients = Client.all(:order => 'klass, name')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clients }
    end
  end

  def byname
    @client = Client.find_by_name(params[:name], :include => :accounts)
    @line = Line.new
    render :action => 'show'
  end
  
  # GET /clients/1
  # GET /clients/1.xml
  def show
    @client = Client.find(params[:id], :include => :accounts)
    @line = Line.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.xml
  def new
    @client = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.xml
  def create
    Client.transaction do 
      @client = Client.new(params[:client])
      ['bar', 'mad', 'tur'].each do |atype|
        Account.create(:atype => atype, :client => @client, :total => 0)
      end
    end

    respond_to do |format|
      if @client.save
        flash[:notice] = 'Client was successfully created.'
        format.html { redirect_to(clients_path) }
        format.xml  { render :xml => @client, :status => :created, :location => @client }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.xml
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        flash[:notice] = 'Client was successfully updated.'
        format.html { redirect_to(@client) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.xml
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to(clients_url) }
      format.xml  { head :ok }
    end
  end
end
