class Question < ApplicationRecord#::Base #дописал из урока (::Base) в оригинале нет

  belongs_to :user

  validates :text, :user, presence: true
end
