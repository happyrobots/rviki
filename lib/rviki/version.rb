# encoding: utf-8
module RViki
  module VERSION

    version = {}
    File.read(File.join(File.dirname(__FILE__), '../', 'VERSION')).each_line do |line|
      type, value = line.chomp.split(":")
      next if type =~ /^ +$/  || value =~ /^ +$/
      version[type] = value
    end

    MAJOR = version['major']
    MINOR = version['minor']
    PATCH = version['patch']
    BUILD = version['build']

    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join('.')

    def self.version
      STRING
    end

  end
end
