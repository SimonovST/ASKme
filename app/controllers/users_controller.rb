class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Stepan',
        username: 'SimonovST',
        avatar_url: 'https://sun9-68.userapi.com/qMj-e0AdKRJ9P6Insj9PFuSzjgvzxiHWsMZX6A/NC3RXg3Crec.jpg'
      ),
      User.new(
        id: 2,
        name: 'Misha',
        username: 'aristofun'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Stepan',
      username: 'SimonovST',
      avatar_url: 'https://sun9-68.userapi.com/qMj-e0AdKRJ9P6Insj9PFuSzjgvzxiHWsMZX6A/NC3RXg3Crec.jpg'
    )

    @questions = [
    Question.new(text: 'Как дела?', created_at: Date.parse('28.03.2021')),
    Question.new(text: 'В чем смысл жизни?', created_at: Date.parse('28.03.2021'))
    ]

    @new_question = Question.new
  end
end
