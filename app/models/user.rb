class User
  include Mongoid::Document

  field :n, as: :name, type: String
  field :p, as: :progress, type: Integer
  field :ti, as: :last_play, type: DateTime

  index({ name: 1 }, { unique: true })
end