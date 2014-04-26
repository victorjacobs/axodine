class Play
  include Mongoid::Document
  field :u, as: :user, type: String
  field :t, as: :title, type: String
  field :a, as: :artist, type: String
  field :ti, as: :time, type: DateTime

  index({ user: 1, ti: 1 })
end