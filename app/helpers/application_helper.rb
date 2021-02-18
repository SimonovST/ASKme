module ApplicationHelper
# Методвозвращает ссылку на аватарку пользователя или стандартную аватарку
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def self.sklonenie(number, begemot, begemota, begemotov, with_number = false)
    ostatok = number % 10
    ostatok100 = number % 100
    prefix = ""
    prefix = "#{number} " if with_number

    return "#{prefix}#{begemotov}" if [11, 12, 13, 14].include?(ostatok100)
    return "#{prefix}#{begemot}" if ostatok == 1
    return "#{prefix}#{begemota}" if [2, 3, 4].include?(ostatok)
    "#{prefix}#{begemotov}"
  end
end
