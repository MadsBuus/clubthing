class SessionsController < ApplicationController

  def index
  end

  def new
    @name = params[:name]
  end

  def create
    if user = User.authenticate(params[:session][:name], params[:session][:password])
      self.current_user = user
      flash[:notice] = "Velkommen #{user.name}"
      redirect_to sessions_path
    else
      flash.now[:error] =  "Kunne ikke finde bruger/password, prøv igen."
      render :action => :new
    end
  end
  
  def logout    
    name = self.current_user.name if logged_in?
    self.current_user = nil
    respond_to do |format|    
      flash[:notice] = "Du er nu logget ud."  
      format.html { redirect_to(new_session_path(:name => name)) }
      format.xml  { head :ok }
    end    
  end
end
