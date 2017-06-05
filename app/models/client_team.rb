# frozen_string_literal: true
class ClientTeam < ActiveRecord::Base
  include ClientMember

  belongs_to :team

  validates :team_id, uniqueness: {scope: :client_id}

  def team_name=(value)
    self.team = Team.find_by(name: value)
  end
end