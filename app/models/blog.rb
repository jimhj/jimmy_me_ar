# coding: utf-8
class Blog < ActiveRecord::Base

  validates_presence_of :title, :content
  validates_length_of :title, :minimum => 2, :maximum => 50
  validates_length_of :content, :minimum => 2, :maximum => 10000
  validates_uniqueness_of :title  

  attr_accessible :title, :content, :slug, :tags

  def tag_list=(value)
    if !value.blank?
      self.tags = value.gsub(/\s/, '').split(/,|，/).join(",")
    end
  end

  def tag_list
    self.tags.split(",")
  end

  TRUNCATE = 600

  def summary
    self.content.truncate(TRUNCATE, :truncate_string => '...')
  end

  def whole_content?
    self.content == self.summary
  end

  before_save do
    if self.slug.blank?
      self.slug = Pinyin.t(self.title, '-')
    else
      errors[:slug] = "Slug is alreay token." if Blog.exists?(:slug => self.slug)
    end
  end  
end
