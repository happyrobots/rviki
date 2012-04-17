# encoding: utf-8
module RViki
  class Printer
    attr_accessor :targets, :object, :format

    def initialize(print_targets=[:stdout])
      self.targets = print_targets
    end

    def do_print
      if self.format
        begin
          self.send(self.format)
        rescue Exception
          self.pretty_json
        end
      else
        self.pretty_json
      end
    end

    def tabular
      return unless inputs_valid?
      raise "Cannot print tabular data because parsed response is not an array" unless object.is_a?(Array)

      out = object.first.keys.join("\t") + "\n"
      object.each { |item| out += (item.values.join("\t") + "\n") }
      do_output out
    end

    def pretty_ruby
      return unless inputs_valid?
      do_output object.pretty_inspect
    end

    def pretty_json
      return unless inputs_valid?
      do_output JSON.pretty_generate(object)
    end

    private

    def inputs_valid?
      raise "Please use array of symbols as targets" unless self.targets.is_a?(Array)
      if !object || object.empty?
        puts "[RViki::Client -- WARNING!] List is empty. Nothing to do here."
        return false
      end
      true
    end

    def do_output(out)
      self.targets.each do |target|
        case target
        when :stdout
          puts out
        when :clipboard
          if command?('pbcopy')
            IO.popen('pbcopy', 'r+') { |cl| cl.puts out }
          elsif command?('xsel')
            IO.popen('xsel –clipboard –input', 'r+') { |cl| cl.puts out }
          else
            puts "[RViki::Client] Cannot copy to clipboard. There is no pbcopy (Mac) or xsel (Linux) installed. Please look for one of them in Google. Thanks."
          end
        else
          puts "[RViki::Client -- WARNING!] Invalid target #{target.inspect}"
        end
      end
    end

    def command?(name)
      `which #{name}`
      $?.success?
    end
  end
end

