class NewsFeed::Target
  include Mongoid::Document

  field :url, type: String

  embedded_in :targetable, polymorphic: true
end
