class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  has_many :users, through: :group_users, source: :user
  
  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image
  
  def is_owned_by?(user)
    owner.id == user.id
  end
  
  def get_image
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
      group_image
  end
  
  # 与えられたUserがグループのメンバーであるかどうかを判定するメソッド
  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end
  
end
