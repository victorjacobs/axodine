class Play
  include Mongoid::Document

  field :_id, type: String, default: ->{Play::generate_id(u, t, a, ti.to_s)}
  field :u, as: :user, type: String
  field :t, as: :title, type: String
  field :a, as: :artist, type: String
  field :ti, as: :time, type: DateTime

  index({ user: 1})
  index({ ti: 1 })

  def self.generate_id(u, t, a, ti)
    Digest::MD5.hexdigest(u + t + a + ti)
  end
end