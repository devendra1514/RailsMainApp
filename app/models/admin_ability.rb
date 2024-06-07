# frozen_string_literal: true

class AdminAbility
  include CanCan::Ability

  def initialize(user)
    case user.present?
    when true
      can :manage, :all
      cannot :destroy, AdminUser
    else
      can :read, ActiveAdmin::Page, name: 'Dashboard'
    end
  end
end
