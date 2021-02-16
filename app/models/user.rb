# Эта библиотека понадобится нам для шифрования.
require 'openssl'

class User < ApplicationRecord
  #Параметры для модуля шифрования паролей
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  EMAIL = /\A.+@.+\..+\z/
  USERNAME = /\A\w+\z/

  attr_accessor :password
  #Связь один ко многим
  has_many :questions
  #Валидация по проверке наличия Email и Username при создание пользователя. без них не пропустит
  validates :email, :username, presence: true
  #Валидация по проверке наличия Email и Username при создание пользователя. Повторяющейся не пропустит
  validates :email, :username, uniqueness: true
  #Валидация по проверке формата электронной почты пользователя
  validates :email, presence: true, format: { with: EMAIL }
  #Валидция по проверке максимальной длины юзернейма пользователя (не больше 40 символов)
  #Валидция по проверке формата юзернейма пользователя (только латинские буквы, цифры, и знак _)
  validates :username, length: { in: 2..40 }
  # validates :username, format: { with: USERNAME }, presence:true

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  #Приведение к нижнему регистру
  before_validation :change_case!
  #сохранение зашифрованого пароля в базу
  before_save :encrypt_password

    # Служебный метод, преобразующий бинарную строку в шестнадцатиричный формат,
  # для удобства хранения.
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  # Основной метод для аутентификации юзера (логина). Проверяет email и пароль,
  # если пользователь с такой комбинацией есть в базе, возвращает этого
  # пользователя. Если нет — возвращает nil.
  def self.authenticate(email, password)
    # Сперва находим кандидата по email
    user = find_by(email: email)

   # Если пользователь не найден, возвращает nil
    return nil unless user.present?

    # Формируем хэш пароля из того, что передали в метод
    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )
    # Обратите внимание: сравнивается password_hash, а оригинальный пароль так
    # никогда и не сохраняется нигде. Если пароли совпали, возвращаем
    # пользователя.
    return user if user.password_hash == hashed_password
    # Иначе, возвращаем nil
    nil
  end

  def change_case!
    username&.downcase!
    email&.downcase!
  end

  private
  def encrypt_password
    if password.present?
      # Создаем т.н. «соль» — случайная строка, усложняющая задачу хакерам по
      # взлому пароля, даже если у них окажется наша БД.
      #У каждого юзера своя «соль», это значит, что если подобрать перебором пароль
      # одного юзера, нельзя разгадать, по какому принципу
      # зашифрованы пароли остальных пользователей
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      # Создаем хэш пароля — длинная уникальная строка, из которой невозможно
      # восстановить исходный пароль. Однако, если правильный пароль у нас есть,
      # мы легко можем получить такую же строку и сравнить её с той, что в базе.
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
      # Оба поля попадут в базу при сохранении (save).
    end
  end
end
