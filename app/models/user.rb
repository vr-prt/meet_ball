class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :games
  has_one_attached :photo
  has_many :players, dependent: :destroy
  has_many :user_badges, dependent: :destroy
  has_many :badges, -> { distinct }, through: :user_badges

  validates :username, presence: true, uniqueness: true
  validates :photo, presence: true

  enum rank: {
    rank1: 0,
    rank2: 1,
    rank3: 2,
    rank4: 3,
    rank5: 4,
    rank6: 5
  }

  def find_enum_from_rank

    #rank: @user.find_enum_from_rank

    User.ranks[self.rank]
  end
end
