# The QuestionHandler class acts as the
# 'Handler' for this implementation of
# the Chain of Responsibility pattern.
class QuestionHandler
  attr_reader :successor

  # We create a pointer to the
  # successor in the chain of
  # responsibility upon intialization.
  def initialize(successor = nil)
    @successor = successor
  end

  def process_request(request)
    # First, the handler attempts to process
    # the request.
    if accept_request(request)
      return

    elsif @successor
      # If the request does not meet the criteria
      # of the handler in question, then, if there
      # is a successor, the request is passed to
      # the successor.
      @successor.process_request(request)
    else
      # If the request does not meet the criteria
      # of this handler, and there is no successor
      # in the chain of responsibility, we'll let
      # the client know that the request has not
      # been fulfilled.
      fail_request(request)
    end
  end

  def fail_request(request)
    puts "The question '#{request}' could not be answered."
  end

  # because we want the 'accept_request' method to be
  # implemented by subclasses of the handler base class,
  # we opt to raise an error if it is not implemented.
  #
  # By the way, the 'accept_request' method, as used in
  # the 'process_request' method, is actually an
  # example of the Template Method pattern.
  def accept_request(request)
    raise '#accept_request method must be implemented.'
  end
end

# The 'StarWarsQuestionHandler' is a concrete
# handler class. It is designed to handle a
# request should that request fulfill certain
# criteria.
class StarWarsQuestionHandler < QuestionHandler
  def accept_request(request)
    # If the request contains the phrase "Star Wars"
    # then this handler will answer the question at
    # hand, then return 'true' to terminate the chain
    # of responsibility. Otherwise, it will forward
    # the question on to other handlers by returning
    # 'false'.
    if request.include?("Star Wars")
      answer_question(request)
      return true
    else
      return false
    end
  end

  # Pretend this does something useful.
  def answer_question(request)
    puts "answering a Star Wars related question: '#{request}'"
  end
end

# The 'HarryPotterQuestionHandler' is a concrete
# handler class. It is designed to handle a request
# should that request fulfill certain criteria.
class HarryPotterQuestionHandler < QuestionHandler
  def accept_request(request)
    # If the request contains the phrase "Harry Potter"
    # then this handler will answer the question at
    # hand, then return 'true' to terminate the chain
    # of responsibility. Otherwise, it will forward
    # the question on to other handlers by returning
    # 'false'.
    if request.include?("Harry Potter")
      answer_question(request)
      return true
    else
      return false
    end
  end

  # Pretend this does something useful.
  def answer_question(request)
    puts "answering a Harry Potter related question: '#{request}'"
  end
end

# Ditto the above two classes.
class LordOfTheRingsQuestionHandler < QuestionHandler
  # BTW, it goes without saying that these question
  # handlers are quite useless, as they only match
  # a single phrase, and provide no actual answers.
  # Therefore, a little imagination must be used
  # on behalf of the reader.
  def accept_request(request)
    if request.include?("Lord of the Rings")
      answer_question(request)
      return true
    else
      return false
    end
  end

  # Pretend this does something useful.
  def answer_question(request)
    puts "answering a Lord of the Rings related question: '#{request}'"
  end
end


# Here, we implement the chain of responsibility.
chain_of_responsibility = HarryPotterQuestionHandler.new(
  StarWarsQuestionHandler.new(
    LordOfTheRingsQuestionHandler.new
  )
)

# We ask questions and we get answers. We have no idea
# which class has answered them, and we don't care. That's
# the beauty of the Chain of Responsibility pattern.
chain_of_responsibility.process_request(
  "What is the longest wand in Harry Potter?"
)
# > answering a Harry Potter related question:
# > 'What is the longest wand in Harry Potter?'

chain_of_responsibility.process_request(
  "How many Jedi have been featured in Star Wars?"
)
# > answering a Star Wars related question:
# > 'How many Jedi have been featured in Star Wars?'

chain_of_responsibility.process_request(
  "Is Lord of the Rings based on a true story?"
)
# > answering a Lord of the Rings related question:
# > 'Is Lord of the Rings based on a true story?'

# The final question had no cooresponding handler, and could
# not be handled. Therefore, we received a failure message.
chain_of_responsibility.process_request(
  "Can anyone name all of the Avengers from the comic books?"
)
# > The question 'Can anyone name all of the Avengers from the
# > comic books?' could not be answered.