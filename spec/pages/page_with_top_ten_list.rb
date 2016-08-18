module PageWithTopTenList
	include Gizmo::PageMixin

	def top_ten_list_header
		find('.parent .right h1')
	end

	def top_ten_list_content
		find('.top-10-container .top-10-list').find('li')
	end

	def top_ten_list_tips
		find('.parent .right .top-10-container .tips')
	end
end