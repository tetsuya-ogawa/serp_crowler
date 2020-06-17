require "active_model"

class SerpItem
  include ActiveModel::Model

  attr_accessor :title
  attr_accessor :url
  attr_accessor :rank
  attr_accessor :kw
end