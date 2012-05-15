class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String

  embeds_one  :author,    class_name: 'User'
  embedded_in :activity

  validates :body,    presence: true
  validates :author,  presence: true

  attr_accessible :author, :body

  def author?(user)
    self.author == user
  end
end
