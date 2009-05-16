class LinesController < ApplicationController

  def index
    @client = Client.find(params[:client_id])
    @account = Account.find(params[:account_id], :include => :lines)
    @lines = @account.lines
  end

  # POST /lines
  # POST /lines.xml
  def create
    @line = Line.new(params[:line])
    deposit(@line)
    redirect_to(@line.account.client)
  end

  def deposit(line)
    account = line.account
    account.transaction do
      line.save
      account.total += line.amount
      account.save
    end
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
