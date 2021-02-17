module ApplicationHelper
# Методвозвращает ссылку на аватарку пользователя или стандартную аватарку
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end
end
