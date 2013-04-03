class Addressbook < ActiveRecord::Base
  attr_accessible :name, :url
  validates :name, :url, :presence => true
  validates :name, :uniqueness => true
  validates :url, :format => {
	:with => %r{\.(com|net|org)}i,
	:message => 'must be a valid URL'
  }
end
