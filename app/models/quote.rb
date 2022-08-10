class Quote < ApplicationRecord
  validates :name, presence: true

  belongs_to :company

  scope :ordered, -> { order(id: :desc) }

  after_create_commit -> { broadcast_prepend_to [ quote.company, "quotes" ] }
end
