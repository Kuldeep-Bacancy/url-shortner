class Link < ApplicationRecord
  validates :url, presence: true

  scope :latest, -> { order(created_at: :desc) }

  def encoded_id
    ShortCode.encode(id)
  end

  def decoded_id
    ShortCode.decode(id)
  end
end
