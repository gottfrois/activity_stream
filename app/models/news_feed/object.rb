class NewsFeed::Object
  include Mongoid::Document

  field :url, type: String

	embedded_in :objectable, polymorphic: true
end
