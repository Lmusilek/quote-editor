class Quote < ApplicationRecord
  validates :name, presence: true

  has_many :line_item_dates, dependent: :destroy
  belongs_to :company

  scope :ordered, -> { order(id: :desc) }

  # after_create_commit -> { broadcast_prepend_to "quotes" }
  broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend
end
