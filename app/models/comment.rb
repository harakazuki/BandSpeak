class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :reports, as: :reportable, dependent: :destroy
  
  validates :content, presence: true
end
