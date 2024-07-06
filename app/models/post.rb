class Post <  ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :link, format: { with: URI::regexp(%w[http https]), message: "must be a valid URL" }, allow_blank: true

end
