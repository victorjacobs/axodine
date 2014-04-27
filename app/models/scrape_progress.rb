class ScrapeProgress
  include Mongoid::Document

  field :u, as: :user, type: String
  field :t, as: :to, type: Integer

  index({ user: 1 })
end