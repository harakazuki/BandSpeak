class Post <  ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  enum tag: { インディーズ: 0, メジャー: 1, デビュー前: 2, 不明: 3 }
  validates :title, presence: true
  validates :body, presence: true
  validates :link, format: { with: URI::regexp(%w[http https]), message: I18n.t('activerecord.errors.messages.url') }, allow_blank: true
  validates :tag, presence: true


  def self.tag_options
    tags.keys.map { |tag| [tag, tag] }
  end
end
