class LineItemDate < ApplicationRecord
  validates :date, presence: true, uniqueness: { scope: :quote_id }

  belongs_to :quote
  has_many :line_items, dependent: :destroy
  
  scope :ordered, -> { order(date: :asc) }

  def previous_date
    quote.line_item_dates.ordered.where("date < ?", date).last
  end
end
