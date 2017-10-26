require 'pry'

task :console => :environment do
  Pry.start
end
