class ChildrenController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:auto_complete_for_child_name]

  def auto_complete_for_child_name
    @pattern = params[:child][:name].split
    @matches = Child.find(:all, :include => [:accounts, :klass], :conditions => ['children.name like ?', "%#{@pattern.first}%"])
    render :layout => false
  end

  # GET /children
  # GET /children.xml
  def index
    if(params[:child])
      child = Child.find_by_name(params[:child][:name])
      if child
        redirect_to(child)
      else
        flash[:notice] = 'Barn ikke fundet'
        redirect_to(children_path)
      end
      return
    end
    @children = Child.all(:include => :klass, :order => 'klasses.startyear, klasses.name, children.name')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @children }
    end
  end

  def byname
    @child = Child.find_by_name(params[:name], :include => :accounts)
    @line = Line.new
    render :action => 'show'
  end

  # GET /children/1
  # GET /children/1.xml
  def show
    @child = Child.find(params[:id], :include => :accounts)
    @line = Line.new

    respond_to do |format|
      format.html { render :layout => 'kiosk'}# show.html.erb
      format.xml  { render :xml => @child }
    end
  end

  # GET /children/new
  # GET /children/new.xml
  def new
    unless Klass.exists?
      flash[:notice] = 'Ingen klasse til elev. Opret klasse først.' 
      redirect_to(klasses_path)
      return
    end
    @child = Child.new
    @child.klass_id = params[:klass_id]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @child }
    end
  end

  # GET /children/1/edit
  def edit
    @child = Child.find(params[:id])
  end

  # POST /children
  # POST /children.xml
  def create
    @child = Child.new(params[:child])
    respond_to do |format|
      if @child.save
        flash[:notice] = 'Barn oprettet.'
        format.html { redirect_to(children_path) }
        format.xml  { render :xml => @child, :status => :created, :location => @child }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @child.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /children/1
  # PUT /children/1.xml
  def update
    @child = Child.find(params[:id])

    respond_to do |format|
      if @child.update_attributes(params[:child])
        flash[:notice] = 'Information opdateret.'
        format.html { redirect_to(children_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @child.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /children/1
  # DELETE /children/1.xml
  def destroy
    @child = Child.find(params[:id])
    @child.destroy

    respond_to do |format|
      format.html { redirect_to(children_url) }
      format.xml  { head :ok }
    end
  end
end
