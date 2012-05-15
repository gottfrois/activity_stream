class Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :verb,            type: String, default: ''

  embeds_one :actor,      as: :actorable
  embeds_one :object,     as: :objectable
  embeds_one :target,     as: :targetable
  embeds_many :comments

  validates :actor,       presence: true
  validates :verb,        presence: true
  validates :object,      presence: true
  # validates :target,    presence: true

  before_save :save_types

private

  def save_types
    self.actor._type  = self.actor.class.name  if self.actor
    self.object._type = self.object.class.name if self.object
    self.target._type = self.target.class.name if self.target
  end
end