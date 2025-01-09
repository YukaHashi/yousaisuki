class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belong_to :owner, class_name: 'User'
  has_many :users, through: :group_users
  
  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :image
  
  def is_owned_by?(user)
    owner.id == user.id
  end
  
  # imageを呼び出したときに中身が空の場合、assets/images/no_image.jpgを呼び出す
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
end
