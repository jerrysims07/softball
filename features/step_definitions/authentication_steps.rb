Then(/^I perform HTTP authentication as "(.*?)", "(.*?)"$/) do |arg1, arg2|
  page.driver.browser.authorize arg1, arg2
end

Given(/^I am logged in$/) do
  if page.driver.respond_to?(:basic_auth)
    puts 'Responds to basic_auth'
    page.driver.basic_auth(username, password)
  elsif page.driver.respond_to?(:basic_authorize)
    puts 'Responds to basic_authorize'
    page.driver.basic_authorize(username, password)
  elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
    puts 'Responds to browser_basic_authorize'
    page.driver.browser.basic_authorize('commish', 'softball')
  else
    raise "I don't know how to log in!"
  end
end
