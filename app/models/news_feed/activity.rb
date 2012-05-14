class NewsFeed::Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :verb, type: String, default: ''

  embeds_one :actor,    as: :actorable,   class_name: 'NewsFeed::Actor'
  embeds_one :object,   as: :objectable,  class_name: 'NewsFeed::Object'
  embeds_one :target,   as: :targetable,  class_name: 'NewsFeed::Target'

  validates :actor,     presence: true
  validates :verb,      presence: true
  validates :object,    presence: true
  # validates :target,    presence: true

  before_save :save_type

private

  def save_type
    self.actor._type  = self.actor.class.name  if self.actor
    self.object._type = self.object.class.name if self.object
    self.target._type = self.target.class.name if self.target
  end
end
