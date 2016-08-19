require 'rails_helper'

RSpec.feature 'post feature', type: :feature do

  scenario 'create/edit/destory post' do
    visit '/posts'

    on_page_with :post_list do |page|
        expect(page.posts_in_list.length).to eq(0)
        page.new_post_link.click
    end

    on_page_with :new_post do |new_page|
        new_page.perform :fill_post, 'my first post', 'I wanna be the full-stack dev'
        new_page.create_post_button.click

        expect(new_page.notice_message).to eq('Post was successfully created.')

        new_page.edit_link.click
        
        new_page.perform :fill_post, 'my updated post', 'I wanna be the full-stack dev yep'
        new_page.update_post_button.click

        expect(new_page.notice_message).to eq('Post was successfully updated.')
        expect(new_page).to have_content('my updated post')
        expect(new_page).to have_content('I wanna be the full-stack dev yep')
        
        new_page.back_link.click
    end

    on_page_with :post_list do |page|
        expect(page.posts_in_list.length).to eq(1)
        expect(page.title).to have_content('my updated post')
        expect(page.content).to have_content('I wanna be the full-stack dev yep')
    end

     on_page_with :top_ten_list do |top_ten_page|
        expect(top_ten_page).to have_content("TOP 10 Posts")
        expect(top_ten_page.top_list_tips).not_to have_content("initialize component")
        expect(top_ten_page.top_list_tips).not_to have_content("start loading...")
        expect(top_ten_page).to have_content("my updated post")
        expect(top_ten_page.top_lists.length).to eq(1)
        expect(top_ten_page.fisrt).to have_content('my updated post')
    end

    on_page_with :post_list do |page|
       page.edit_post_link.click
    end

    on_page_with :new_post do |update_page|
        expect(update_page).to have_content('Editing Post')
        
        update_page.perform :fill_post, 'my edit post', 'Test Edit Post'
        update_page.update_post_button.click
        
        expect(update_page.notice_message).to eq('Post was successfully updated.')
        
        update_page.back_link.click
    end

    on_page_with :post_list do |page|
		expect(page.title).to have_content('my edit post')
		expect(page.content).to have_content('Test Edit Post')
       	
		page.destory_post_link.click
		page.destory_deny
       
		expect(page.posts_in_list.length).to eq(1)
		expect(page.title).to have_content('my edit post')
		expect(page.content).to have_content('Test Edit Post')

		page.destory_post_link.click
		page.destory_accept

		expect(page.posts_in_list.length).to eq(0)
		expect(page).to have_content('Post was successfully destroyed.')
    end
  end
end
