class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  
  has_one_attached :profile_image
  
  # 複数のPostCommentモデルと関連付け、Userが削除されたとき関連するコメントを削除する。
  has_many :post_comments, dependent: :destroy
  
  has_many :group_users, dependent: :destroy
  has_many :groups, through:  :group_users
  
  # バリテーションの設定
  validates :name, presence: true
  validates :email, presence: true
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  # is_deletedがfalseならtrueを返すように
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  # 検索方法の分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

end
