module PageWithPostList
	include Gizmo::PageMixin

	def valid?
		has_css?('.parent .left')
	end

	def title
		find('.title')
	end

	def content
		find('.content')
	end

	def posts_in_list
		find('.parent .left table').find('tbody').all('tr')
	end

	def new_post_link
		find('.parent .left a[href="/posts/new"]')
	end

	def edit_post_link
		find_link('Edit')
	end

	def destory_post_link
		find_link('Destroy')
	end
	
	def destory_accept
		page.driver.browser.switch_to.alert.accept  
	end

	def destory_deny
		page.driver.browser.switch_to.alert.dismiss
	end
end