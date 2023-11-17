# frozen_string_literal: true

class TestJob < ApplicationJob
  queue_as :default

  def perform
    puts '----------------------ACTIVE JOB PROCESSED-------------------------'
  end
end
