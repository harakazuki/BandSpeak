class Report < ApplicationRecord
  belongs_to :reportable, polymorphic: true
  belongs_to :user
  
  enum status: { 未対応: 0, 対応済み: 1 }
  
  validates :reason, presence: true, length: { maximum: 500 }
end
