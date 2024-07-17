class Post <  ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  enum tag: { インディーズ: 0, メジャー: 1, デビュー前: 2, 不明: 3 }
  validates :title, presence: true
  validates :body, presence: true
  validates :link, format: { with: URI::regexp(%w[http https]), message: "must be a valid URL" }, allow_blank: true

end
