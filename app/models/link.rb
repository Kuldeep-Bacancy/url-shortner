class Link < ApplicationRecord
  validates :url, presence: true
  validate :validate_url

  scope :latest, -> { order(created_at: :desc) }

  def encoded_id
    ShortCode.encode(id)
  end

  def decoded_id
    ShortCode.decode(id)
  end

  private

  def validate_url
    url_regex = /\Ahttps?:\/\/[\S]+\z/i
    unless url.match(url_regex)
      errors.add(:url, 'is not a valid URL')
    end
  end
end
