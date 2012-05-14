class NewsFeed::Actor
	include Mongoid::Document

	field :url, type: String

	embedded_in :actorable, polymorphic: true
end
