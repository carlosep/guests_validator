class Event < ApplicationRecord
  has_many :guests

  before_save :default_attributes

  def default_attributes
    self.tolerance ||= 10
  end

  def min_tolerance
    starts_at - tolerance.minutes
  end

  def max_tolerance
    starts_at + tolerance.minutes
  end
end
