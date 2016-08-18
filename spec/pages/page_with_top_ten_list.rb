module PageWithTopTenList
	include Gizmo::PageMixin

	def valid?
		has_css?('.parent .right .top-10-container .tips')
	end

	def top_list_tips
		find('.parent .right .top-10-container .tips')
	end

	def top_lists
		find('.parent .right .top-10-container .top-10-list').all('li')
	end

	def fisrt
		find('.parent .right .top-10-container .top-10-list>li')
	end
end