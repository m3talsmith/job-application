require 'open-uri'
require 'rubygems'
require 'json'

# GitHub Project Log
#
# You can use this to a commit of any public project on github.com
# --
# Usage: ruby github_project_log.rb user_name/project_name
#
# You can optionally add a branch like:
#   ruby github_project_log.rb user_name/project_name/branch_name
#
# The output will be in html

# Check for the required arguments from the command line: exit if not found
if ARGV.length < 1 || ARGV[0].split("/").length < 2
  puts "\nUsage: ruby github_project_log.rb user_name/project_name\n\n"
  Process.exit!
end

# Grab the user, project, and branch info from the command line
user, project, branch = ARGV[0].split("/")
branch                = branch ? branch : "master"

# Get our all of our data in order or exit
begin
  response = open("http://github.com/api/v2/json/commits/list/#{user}/#{project}/#{branch}")

rescue OpenURI::HTTPError
  puts "\n** You put in a bad user name, project name, or branch name: http://github.com/api/v2/json/commits/list/#{user}/#{project}/#{branch} \nPlease try again.\n\n"
  Process.exit!
end

commits = JSON.parse(response.read)["commits"].group_by {|commit| commit["author"]}

# Start formatting the data
html = "<html><head><title>Commit History for #{project} owned by #{user}</title></head><body>"

html << "<h1>Commit History for #{project} owned by #{user}</h1>"
commits.each do |author, author_commits|
  html << "<div class='author'>"
  html << "  <h2>#{author['name']} (#{author['login']})</h2>"
  html << "  <ul class='commits'>"
  author_commits.each do |commit|
    html << "    <li class='commit'>Commit: <span class='id'>#{commit['id']}</span><br />"
    html << "    <span class='message'>#{commit['message']}</span></li>"
  end
  html << "  </ul>"
  html << "</div>"
end
html << "</div>"

html << "</body></html>"

# Return the finished html
puts html

# Exit the program properly
exit