class ScribbleComment < ActiveRecord::Base
	attr_accessible :body, :commenter, :commentor_id, :down, :up
	belongs_to :forscribble,
	:class_name => 'Scribble',
	:primary_key => 'scribble_id',
	:foreign_key => 'scribble_id'

	belongs_to :wrote_by,
	:class_name => 'User',
	:primary_key => 'beamer_id',
	:foreign_key => 'commentor_id'

end
