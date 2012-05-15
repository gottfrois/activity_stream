class User
  include Mongoid::Document

  field :first_name, 		type: String
  field :last_name, 		type: String
  field :email,         type: String

  validates :first_name, 	presence: true
  validates :last_name, 	presence: true
  validates :email,       presence: true

  before_validation :choose_email

  def name
    [self.first_name, self.last_name].join(' ')
  end

  def activities
    NewsFeed::Activity.where(:"actor._id" => self.id)
  end

private

  def choose_email
    self.email = "#{self.first_name.downcase}.#{self.last_name.downcase}@gmail.com"
  end
end
