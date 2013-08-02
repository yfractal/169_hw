Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

Given /^I delete the movie: "(.*?)"$/ do |title|
  steps %{
    Given I am on the "#{title}" movie page
    And I press "Delete"
  }  
end


Given(/^I check the following ratings: (.*)$/) do |ratings|
		ratings.split(",").each do |rating|
			check("ratings_#{rating}")
		end
end

Given(/^I uncheck the following ratings: (.*)$/) do |ratings|
		ratings.split(",").each do |rating|
			uncheck("ratings_#{rating}")
		end
end

Then(/^I should see the movies: "(.*?)"$/) do |movies|
	movies  = movies.split(",")
	movies.each do |movie|
		steps %{
			Then I should see "#{movie}"
		}
	end
end
Then(/^I should not see the movies: "(.*?)"$/) do |movies|
	movies  = movies.split(",")
	movies.each do |movie|
		steps %{
			Then I should not see "#{movie}"
		}
	end
end
Then(/^I should (\d+) movies in movies' table$/) do |arg1|
# !!!!!!!!!!!!!
	all("table#movies tr").count == 10
# !!!!!!!!!!!!!
end

Then(/^I should see "(.*?)" before "(.*?)"$/) do |s1,s2|
	regexp = /#{s1}.*#{s2}/
	page.body =~ regexp
end

