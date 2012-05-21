class User
  include Mongoid::Document
  # include Mongo::Voter

  devise :database_authenticatable, :registerable, :rememberable

  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ''
  field :encrypted_password, :type => String, :null => false, :default => ''

  ## Rememberable
  field :remember_created_at, :type => Time

  field :first_name,          type: String
  field :last_name,           type: String

  validates :first_name,  presence: true
  validates :last_name,   presence: true
  validates :email,       presence: true

  def name
    [self.first_name, self.last_name].join(' ')
  end

  def activities
    Activity.where(:"actor._id" => self.id)
  end
end
