require 'pry'
require_relative 'bank_account.rb'
class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end
  
  def valid?
    if sender.valid? && receiver.valid?
      return true
    else
      false
    end
  end
  
  def execute_transaction
    if (@status == "pending") && (@sender.balance > @amount) && (self.valid?)
      
      @sender.withdrawal(@amount)
      @receiver.deposit(@amount)
      @status = "complete"
    else
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end
  
  def reverse_transfer
    if self.status == "complete"
      @sender.deposit(@amount)
      @receiver.withdrawal(@amount)
      @status = "reversed"
    end
  end
end
