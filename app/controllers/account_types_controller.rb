class AccountTypesController < ApplicationController
  # GET /account_types
  # GET /account_types.xml
  def index
    @grouped_result = 
     ActiveRecord::Base.connection.execute(
      'SELECT account_type_id, date, sum("lines".amount) as sum ' +
      'FROM "lines" LEFT OUTER JOIN "accounts" ON "accounts".id = "lines".account_id ' +
      'GROUP BY date, account_type_id ORDER by date DESC, account_type_id, sum LIMIT 200 '
     )    
    @account_types = AccountType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @account_types }
    end
  end

  # GET /account_types/1
  # GET /account_types/1.xml
  def show
    @account_type = AccountType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account_type }
    end
  end

  # GET /account_types/new
  # GET /account_types/new.xml
  def new
    @account_type = AccountType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account_type }
    end
  end

  # GET /account_types/1/edit
  def edit
    @account_type = AccountType.find(params[:id])
  end

  # POST /account_types
  # POST /account_types.xml
  def create
    @account_type = AccountType.new(params[:account_type])

    respond_to do |format|
      if @account_type.save
        flash[:notice] = 'AccountType was successfully created.'
        format.html { redirect_to(@account_type) }
        format.xml  { render :xml => @account_type, :status => :created, :location => @account_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /account_types/1
  # PUT /account_types/1.xml
  def update
    @account_type = AccountType.find(params[:id])

    respond_to do |format|
      if @account_type.update_attributes(params[:account_type])
        flash[:notice] = 'AccountType was successfully updated.'
        format.html { redirect_to(@account_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /account_types/1
  # DELETE /account_types/1.xml
  def destroy
    @account_type = AccountType.find(params[:id])
    @account_type.destroy

    respond_to do |format|
      format.html { redirect_to(account_types_url) }
      format.xml  { head :ok }
    end
  end

  def list
    @klasses = Klass.all(:order => 'startyear desc, name', :include => :children)
  end

  def multiline
    @account_type = AccountType.find(params[:list][:account_type])
    @price = params[:list][:price]
    @description = params[:list][:name]

    if params[:commit] == 'Udskriv tilmeldingsliste'
      #just preview list
      @klasses = Klass.all(:order => 'startyear desc, name', :include => :children)
      render 'printlist', :layout => false
    else
      price = - @price.to_i.abs
      @attendees = Child.find(params[:list][:child], :order => :name)
      Child.transaction do
        @attendees.each do |attendee|
          line = Line.new
          line.amount = price
          line.account = attendee.accounts.find(:first, :conditions => ['account_type_id = ?', @account_type.id])
          line.comment = "#{Date.today} : #{@description}"
          line.deposit
        end
        flash.now[:notice] = 'Beløb trukket fra alle tilmeldte.'
      end
    end
  end
end