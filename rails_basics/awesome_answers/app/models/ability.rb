class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    if user.is_admin?
      can :manage, :all  # manage means they can do everything (not just CRUD)
    end
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    alias_action(:create, :read, :update, :destroy, to: :crud)

    can(:crud, Question) do |question|
      user == question.user
    end

    can(:crud, Answer) do |answer|
      user == answer.user
    end
    
    can(:crud, JobPost) do |job_post|
      user == job_post.user
    end

    can(:like, Question) do|question|
      user.persisted? && question.user != user
      # user.persisted? check if this user is saved in the database
      # the owner of the question can not like their own question
    end

    can(:destroy, Like) do |like|
      like.user == user
    end
  end
end
