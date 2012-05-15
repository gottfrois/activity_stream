class UserPresenter < BasePresenter
  presents :user

  def avatar
    link_to(gravatar_image_tag(user.email, { gravatar: { size: 48 } }), user_path(user), :class => 'actor')
  end

  def name
    link_to user.name, user_path(user)
  end
end