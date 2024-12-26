class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  # 複数のPostCommentモデルと関連付け、Postが削除されたとき関連するコメントを削除する。
  has_many :post_comments, dependent: :destroy

  
  
  # バリテーションの設定
  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image
  end
  
    # 検索方法の分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @post = Post.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
  
end
