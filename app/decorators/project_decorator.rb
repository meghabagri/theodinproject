require 'delegate'

class ProjectDecorator < SimpleDelegator

  def owner
    user.username
  end

  def number_of_votes
    votes_for.size
  end
end
