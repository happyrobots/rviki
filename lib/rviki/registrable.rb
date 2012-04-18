# encoding: utf-8
module Registrable
  def self.included(base)
    base.send :extend, ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def register_command(command_sym, args)
      registered_commands[command_sym] = args
    end

    def registered_commands
      @registered_commands ||= {}
    end

    def api_version(version=nil)
      if version.is_a?(String)
        @api_version = version
      end
      @api_version
    end

    def binary_name(name=nil)
      if name.is_a?(String)
        @binary_name = name
      end
      @binary_name
    end

    def examples(ex=nil)
      if ex.is_a?(String)
        @examples = ex
      end
      @examples
    end
  end

  module InstanceMethods
    def prepare_printer
      @printer = RViki::Printer.new([:stdout])

      @print_opts_parser = OptionParser.new do |pop|
        pop.banner = "Print Options:"
        pop.on("-f", "--format FORMAT", [:tabular, :pretty_json, :pretty_ruby],
               "Print with FORMAT (tabular (only for array), pretty_json, or pretty_ruby)") do |pf|
          printer.format = pf
        end

        pop.on("-o", "--output clipboard,stdout", Array,
               "Output to OUTPUT_TARGET (clipboard, stdout)") do |o|
          o = o.map(&:to_sym)
          if (o.include?(:clipboard) || o.include?(:stdout))
            printer.targets = o
          end
        end
      end
    end

    def execute(*args)
      prepare_printer

      @cmd = args.shift
      @cmd = @cmd.to_sym if @cmd
      unless valid_command?
        puts <<-EOL

Command not found: #{@cmd}
----------------------------------------

RViki Version #{RViki::VERSION::STRING} for Viki API #{self.class.api_version}
Usage: #{self.class.binary_name} <api_endpoint> [--opt optvalue] [api_param1] [api_param2]

Available API Endpoints:
#{commands_listing}
#{print_opts_parser}

Examples:

#{self.class.examples}

EOL
        exit(1)
      end

      @cmd_args = self.class.registered_commands[@cmd]
      extract_options args
      response = client.send(@cmd, client_options_hash)
      printer.object = response.parsed_response
      printer.do_print
    end

    protected

    attr_reader :client, :printer, :client_options, :print_opts_parser

    def commands_listing
      result = ""
      self.class.registered_commands.each do |endpoint, params|
        result += "    #{endpoint}"
        result += "\n        params: #{params.map{|pr| "[:#{pr}]"}.join(' ')}" if params && !params.empty?
        result += "\n"
      end
      result
    end

    def extract_options(args)
      client_opts_i = 0
      args.each_with_index do |a, i|
        client_opts_i += 2 if a.start_with?("-")
      end

      @printer_options = args[0...client_opts_i]
      print_opts_parser.parse! @printer_options
      @client_options = args[client_opts_i..-1]
      true
    end

    def client_options_hash
      options = {}
      client_options.each_with_index do |a, i|
        options[@cmd_args[i]] = a
      end
      options
    end

    def valid_command?
      @cmd && !@cmd.empty? && self.class.registered_commands.has_key?(@cmd)
    end
  end
end

