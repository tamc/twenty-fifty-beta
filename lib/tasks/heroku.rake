namespace :heroku do
  desc "Deploy the 2050 calculator to heroku"
  task :deploy => ['dev:updated_view'] do
    puts `cd #{RAILS_ROOT}`
    puts `git add --all`
    puts `git commit -m 'Update at #{Time.now}'`
    puts `git push heroku master`
  end
  
  desc "Create a new heroku instance and deploy to it"
  task :create => ['dev:updated_view'] do
    puts "Creating git repository"
    puts `cd #{RAILS_ROOT}`
    puts `git init`
    puts `git add --all`
    puts `git commit -m 'Update at #{Time.now}'`
    
    puts "Creating heroku instance"
    puts `heroku create  --stack bamboo-mri-1.9.2`
    puts `git push heroku master`
    puts `heroku rake db:migrate`
    puts `heroku dynos 1`
    puts `heroku workers 1`
  end
end