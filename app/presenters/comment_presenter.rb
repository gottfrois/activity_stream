class CommentPresenter < BasePresenter
  presents :comment
  delegate :body, :to => :comment

  # Display metadata links and information for given comment.
  #
  # @param [Hash] options the options to display metatada.
  # @option options [Bool] :like Whether to display like link.
  # @option options [Bool] :like_count Whether to display like counts.
  # @option options [Bool] :comment Whether to display comment link.
  # @option options [Bool] :date Whether to display date.
  #
  # @return [String]
  def metadata(*args)
    return '' unless user_signed_in?
    options = args.extract_options!
    options[:date]        ||= true
    options[:comment]     ||= true
    options[:like]        ||= true
    options[:like_count]  ||= false

    out = []
    out << "#{time_ago_in_words(comment.created_at).capitalize} ago"                                if options[:date]        && comment.respond_to?(:created_at)
    out << link_to('Comment', '#')                                                                  if options[:comment]     && comment.respond_to?(:comments)
    out << link_to('Like', comment_likes_path(comment),    :method => 'post')                       if options[:like]        && comment.respond_to?(:vote)       && !current_user.voted?(comment)
    out << link_to('Unlike', comment_likes_path(comment),  :method => 'destroy')                    if options[:like]        && comment.respond_to?(:vote)       && current_user.voted?(comment)
    out << link_to(content_tag(:i, '', :class => 'icon-heart') + " #{comment.up_votes_count}", '#') if options[:like_count]  && comment.respond_to?(:vote)       && comment.up_votes_count > 0

    return raw out.join(" &middot; ")
  end

  def author
    link_to comment.author.name, comment.author
  end

  def deletable(parent = nil)
    link_to raw('&times;'), [parent, comment], :class => "close", :method => 'delete', :confirm => 'Are you sure you want to permanently delete this comment?'
  end
end