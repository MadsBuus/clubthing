class LinesController < ApplicationController
  
  MAX_AMOUNT=1000
  
  def index
    if(params[:child_id])
      @child = Child.find(params[:child_id])
      @account = Account.find(params[:account_id], :include => :lines)
      @lines = @account.lines.recent
      @oldsum = @account.lines.old.sum(:amount)
    else
      #global lines link, show possible comments...
      @comments = Line.find(:all, :select =>  'distinct comment', :conditions => "comment is not null and comment != ''", :order => 'created_at desc')

      if params[:comment]
        @attendees = Child.find(:all, :include => :lines, :conditions => ['lines.comment = ?', params[:comment]], :order => :name)
        @comment = params[:comment] if @attendees.length > 0
      end
      render :action => 'showcomments'
    end
  end
       
  def all
    if(params[:child_id])
      @child = Child.find(params[:child_id])
      @account = Account.find(params[:account_id], :include => :lines)
      @lines = @account.lines.all.reverse     
      @oldsum = 0
      render :index
    end
  end

  # POST /lines
  # POST /lines.xml
  def create
    entered_amount = params[:line][:amount].strip
    amount = entered_amount.to_i
    amount = - amount.abs unless entered_amount.include? "+"
    @line = Line.new(params[:line])
    if amount == 0
      flash[:error] = "Ugyldig indtastning: #{entered_amount}"
    elsif amount > MAX_AMOUNT
      flash[:error] = "For højt beløb<br/>(max #{MAX_AMOUNT})" 
    elsif amount < -MAX_AMOUNT
      flash[:error] = "For højt beløb<br/>(max #{MAX_AMOUNT})" 
    else
      @line.amount = amount
      @line.comment =  ''
      @line.user = current_user
      @line.deposit
      if amount > 0
        flash[:notice] = "#{@line.account.account_type.title} #{entered_amount}"
        redirect_to(@line)
        return
      else
        flash[:warning] = "#{@line.account.account_type.title} #{entered_amount}"
      end
    end
    redirect_to(@line.account.child)
  end

  def show
    @line = Line.find(params[:id])
  end

  # DELETE /lines/1
  # DELETE /lines/1.xml
  # def destroy
  #   @line = Line.find(params[:id])
  #   @line.destroy

  #  respond_to do |format|
  #     format.html { redirect_to(lines_url) }
  #     format.xml  { head :ok }
  #   end
  # end
end
