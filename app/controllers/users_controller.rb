class UsersController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Stepan',
      username: 'simens',
      avatar_url: 'https://sun9-68.userapi.com/qMj-e0AdKRJ9P6Insj9PFuSzjgvzxiHWsMZX6A/NC3RXg3Crec.jpg'
    )
  end
end
