class Movie < ApplicationRecord
  belongs_to :director

  include PgSearch
  multisearchable against: [:title, :syllabus]
end
