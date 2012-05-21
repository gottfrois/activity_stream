class ActivityPresenter < BasePresenter
  presents :activity
  
  # Display metadata links and information for given activity.
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
    out << "#{time_ago_in_words(activity.created_at).capitalize} ago"                               if options[:date]        && activity.respond_to?(:created_at)
    out << link_to('Comment', '#')                                                                  if options[:comment]     && activity.respond_to?(:comments)
    # out << link_to('Like', activity_likes_path(activity),    :method => 'post')                     if options[:like]        && activity.respond_to?(:vote)       && !current_user.voted?(activity)
    # out << link_to('Unlike', activity_likes_path(activity),  :method => 'destroy')                  if options[:like]        && activity.respond_to?(:vote)       && current_user.voted?(activity)
    # out << link_to(content_tag(:i, '', :class => 'icon-heart') + " #{activity.up_votes_count}", '#') if options[:like_count]  && activity.respond_to?(:vote)       && activity.up_votes_count > 0

    return raw out.join(" &middot; ")
  end

  def text
    case activity.verb
    when 'connected'
      out = %(#{raw link_to(activity.actor.name, activity.actor)} is now connected to #{raw link_to(activity.subject.name, activity.subject)})
    else
      out = %(#{activity.verb})
    end

    return raw out
  end
end