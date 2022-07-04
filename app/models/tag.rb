class Tag < ApplicationRecord
  has_many :book_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :books, through: :book_tags

  scope :merge_books, -> (tags){ }

  def self.looks(search, word)
    if search == "perfect_match"
      @tag = Tag.where(tag_name: word)
    end

    return @tag.inject(init = []) {|result, tag| result + tag.books}
  end
end
