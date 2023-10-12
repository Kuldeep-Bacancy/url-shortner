class Link < ApplicationRecord
  validates :url, presence: true

  scope :latest, -> { order(created_at: :desc) }
end
