# encoding: utf-8

require 'optparse'
require 'rviki'
require 'rviki/registrable'

module RViki
  class Cli1
    include Registrable

    api_version "V1"
    binary_name "rviki1"
    examples <<-EOE
    $ #{binary_name} shows -o clipboard
    $ #{binary_name} shows_item 50
    $ #{binary_name} shows_item 50 es
    $ #{binary_name} shows -f pretty_json 50
    $ #{binary_name} shows -o clipboard,stdout 50
EOE

    def initialize
      @client  = RViki::ClientV1.new
    end

    register_command :shows, [:language_code]
    register_command :shows_item, [:id, :language_code]
  end

  class Cli2
    include Registrable

    api_version "V2"
    binary_name "rviki2"
    examples <<-EOE
    $ #{binary_name} featured
    $ #{binary_name} shows -o clipboard
    $ #{binary_name} shows_item 50
    $ #{binary_name} shows_item 50 es
    $ #{binary_name} shows -f pretty_json 50
    $ #{binary_name} shows -o clipboard,stdout 50
EOE

    def initialize
      @client  = RViki::ClientV2.new
    end

    register_command :shows, [:language_code]
    register_command :shows_item, [:id, :language_code]
    register_command :featured, []
    register_command :news, [:language_code]

    register_command :channels, [:watchable_by_country, :lang_code]
    register_command :channels_item, [:id, :watchable_by_country, :lang_code]
    register_command :channel_videos, [:id]

    register_command :posts, [:lang_code]

    register_command :videos, []
    register_command :video_casts, [:id]
    register_command :video_parts, [:id]
    register_command :video_posts, [:id]
  end

  class Cli3
    include Registrable

    api_version "V3"
    binary_name "rviki3"
    examples <<-EOE
EOE

    def initialize
      @client  = RViki::ClientV3.new
    end

    register_command :custom, [:hash]
  end
end

