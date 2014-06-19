Then(/^I perform HTTP authentication as "(.*?)", "(.*?)"$/) do |arg1, arg2|
  page.driver.browser.authorize arg1, arg2
end

Given(/^I am logged in$/) do
  page.driver.browser.basic_authorize('commish', 'softball')
end
