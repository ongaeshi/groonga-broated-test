require 'fileutils'
require 'find'

task :init do
  FileUtils.rm_rf("./db")
  FileUtils.rm_rf("./ruby-2.1.1")
  sh "milk init db"
  sh "tar xzf ruby-2.1.1.tar.gz"

  Dir.chdir('db') do
    sh "milk add ../ruby-2.1.1"
  end
end

task :do_test do
  rdm = RandomDirectoryManipulator.new('ruby-2.1.1', {seed: 1, verbose: false})

  (1..2).each do |i| 
    puts "-- #{i} --"
    rdm.add_remove_update(1000)

    Dir.chdir('db') do
      sh "milk update --all"
      sh "du -h -d 1 ."
    end
  end
end

class RandomDirectoryManipulator
  def initialize(dir, options = {})
    @dir = dir
    @options = options
    srand(@options[:seed]) if @options[:seed]
  end

  def add_remove_update(num)
    files = dir_files
    
    (1..num).each do
      file = files[rand(files.size)]

      case rand(10)
      when 0
        # Add
        dst = file + "-random_directory_manipulator"
        message "A #{dst}"
        FileUtils.cp(file, dst)
        files << dst
      when 1
        # Remove
        message "R #{file}"
        File.unlink(file)
        files.delete(file)
      else
        # Update
        message "U #{file}"
        open(file, "a") do |io|
          io.puts "random_directory_manipulator"
        end
      end
    end
  end

  def dir_files
    files = []
    
    Find.find(@dir) do |path|
      next if FileTest.directory?(path)
      files << path
    end

    files
  end

  def message(str)
    puts str if @options[:verbose]
  end
end


