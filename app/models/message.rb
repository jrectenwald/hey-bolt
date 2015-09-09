class Message
  attr_accessor :message
  def initialize(name, message)
    @message = "Hi Beany, #{name} has a message for Bolt. Can you read this to him?
    \n\nFrom: #{name}\nTo: Bolt\n\n#{message}\n\nIf he would like to respond, please let him log onto his website and holla back at #{name}."
  end
end