class Activity
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Mongo::Voteable

  # voteable self, up: +1, down: -1

  field :verb,            type: String, default: ''

  embeds_one :actor,      as: :actorable
  embeds_one :subject,    as: :subjectable
  embeds_one :target,     as: :targetable
  embeds_many :comments

  validates :actor,       presence: true
  validates :verb,        presence: true
  validates :subject,     presence: true
  # validates :target,    presence: true

  before_save :save_types

private

  def save_types
    self.actor._type  = self.actor.class.name  if self.actor
    self.subject._type = self.subject.class.name if self.subject
    self.target._type = self.target.class.name if self.target
  end
end
