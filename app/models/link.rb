# frozen_string_literal: true

class Link < ApplicationRecord
  validates :url, presence: true
  validate :validate_url

  scope :latest, -> { order(created_at: :desc) }

  after_create :run_test_job

  def encoded_id
    ShortCode.encode(id)
  end

  def decoded_id
    ShortCode.decode(id)
  end

  private

  def validate_url
    url_regex = %r{\Ahttps?://\S+\z}i
    return if url.match(url_regex)

    errors.add(:url, 'is not a valid URL')
  end

  def run_test_job
    p '-----------------JOB ENQUEUD---------------'
    TestJob.set(wait: 1.minutes).perform_later
  end
end
