require 'sinatra/activerecord'

class Email < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true
end
