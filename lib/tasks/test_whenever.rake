#encoding: utf-8
namespace :jiangling do
  desc 'test whenever'
  task :test_whenever => :environment do
    f = File.open('test_whenever.txt', 'w')
    f.puts Time.now
    f.puts 'hello words!'
    f.close
  end
end