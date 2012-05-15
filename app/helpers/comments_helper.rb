module CommentsHelper
  # Aggregate comments from given item.
  #
  # @param [Class] item a commentable object
  # @param [Hash] options the options to aggregate comments.
  # @option options [Int] :min If number of comments <= :min, then display full comments.
  # @option options [Int] :max If number of comments > :max, then display link to see full comments.
  #
  # @note If number of comments between :min and :max, then display link to see full comments and display last 2 full comments.
  #
  # @return [String]
  def aggregate(item, options = {:min => 2, :max => 10})
    out = ''
    n = item.comments.count
    if n <= options[:min]
      out = render item.comments, :item => item
    elsif n.between?(options[:min], options[:max])
      out = content_tag :li, link_to(content_tag(:i, '', :class => "icon-comment"), '#') + ' ' + link_to("View all #{n} comments", '#'), :class => "well"
      out += render item.comments.values_at(n - 2, -1), :item => item
    else
      out = content_tag :li, link_to(content_tag(:i, '', :class => "icon-comment"), '#') + ' ' + link_to("View all #{n} comments", '#'), :class => "well"
    end
  end
end
