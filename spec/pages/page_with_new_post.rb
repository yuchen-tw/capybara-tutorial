module PageWithNewPost
	include Gizmo::PageMixin

	def notice_message
		find('#notice').text
	end

	def back_link
		find('a[href="/posts"]')
	end

	def edit_link
		find_link('Edit')
	end
	
	def create_post_button
		find('.actions input[value="Create Post"]')
	end

	def update_post_button
		find('.actions input[value="Update Post"]')
	end

	define_action :fill_post do |title, content|
		fill_in('post_title', with: title)
		fill_in('post_content', with: content)
	end
end