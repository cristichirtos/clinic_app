class Notification 
  attr_accessor :content, :sender, :receiver 

  def initialize(params)
    @content = params[:content]
    @sender = params[:sender] 
    @receiver = params[:receiver]
  end
end
