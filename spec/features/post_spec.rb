require 'rails_helper'

RSpec.feature 'post feature', type: :feature do

  scenario 'create new post' do
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
  end
end
