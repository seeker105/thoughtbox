# README

Thoughtbox is a basic site that lets users make a list of web links (bookmarks).
A user can sign up on the site (it's free) and once logged in they can start adding links to their list. An existing link can be edited - Title and Url can be changed. Links can be toggled manually between "Read" and "Unread". They can be sorted alphabetically and filtered by "Read/Unread" status. They can also be filtered by a string to display only those links whose title includes the given word or phrase.

To run the app locally you need to have postgres set up on your machine. Then clone the repo and run

```
bundle
rake db:create
rake db:migrate
```
Then just point your browser to localhost:3000 and enjoy Thoughtbox!

Ruby version: ruby 2.3.0p0

Database: postgres v 9.5.1.0

Test suite is RSpec. To run the test suite after the app is up and running open the root directory and run the `rspec` command.

The test suite uses the 'selenium' webdriver which uses the Firefox browser. Unfortunately, selenium currently does not work with Firefox versions later than 47.0.1. Since most of the site runs on javascript most of the tests require selenium. If your Firefox has auto-updated (or you don't have Firefox) you'll need to download an earlier version from a site like [this](https://support.mozilla.org/en-US/kb/install-older-version-of-firefox). Don't forget to go into Firefox preferences first and turn off the auto-update or you'll just be going in circles.

Live web Deployment is via [heroku](https://nameless-lake-90356.herokuapp.com/)
