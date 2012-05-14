module ActivitiesHelper
  def metadata(*args)
    options = args.extract_options!
    options[:date]        ||= true
    options[:comment]     ||= true
    options[:like]        ||= true
    options[:like_count]  ||= false
    activity = args.first

    out = []
    out << "#{time_ago_in_words(activity.created_at).capitalize} ago"                               if options[:date]        && activity.respond_to?(:created_at)
    out << link_to('Comment', '#')                                                                  if options[:comment]     && activity.respond_to?(:comments)
    # out << link_to('Like', activity_likes_path(activity),    :method => 'post')                     if options[:like]        && activity.respond_to?(:vote)       && !current_user.voted?(activity)
    # out << link_to('Unlike', activity_likes_path(activity),  :method => 'destroy')                  if options[:like]        && activity.respond_to?(:vote)       && current_user.voted?(activity)
    # out << link_to(content_tag(:i, '', :class => 'icon-heart') + " #{activity.up_votes_count}", '#') if options[:like_count]  && activity.respond_to?(:vote)       && activity.up_votes_count > 0

    return raw out.join(" &middot; ")
  end
end
