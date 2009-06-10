class User < ActiveRecord::Base
  include SimplestAuth::Model
  authenticate_by :name
  validates_presence_of :name
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password, :if => :password_required?
end
