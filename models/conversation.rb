class Conversation
  attr_accessor :message, :user

  def initialize(message, user=nil)
    @message = message
    @user = user || message.user
  end

  def root
    message.root
  end

  def for_user
    all.by_user(user)
  end

  def all
    root.subtree
  end

  def trash_conversation!
    for_user.each { |message| message.trash! }
  end
end