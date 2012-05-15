class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String

  embeds_one  :author,    class_name: 'User'
  embedded_in :activity,  class_name: 'NewsFeed::Activity'

  validates :body,    presence: true
  validates :author,  presence: true

  attr_accessible :author, :body
end
