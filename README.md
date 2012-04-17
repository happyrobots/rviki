# RViki 0.0.1 readme


RViki is a Ruby client gem for Viki.com API.


## Usage

### Client Request

    v = RViki::Client.new
    v.shows
    v.shows(language_code: "en")
    v.shows(id: 50)
    v.shows(id: 50, language_code: "es")

### Print Utilities

    vpr = RViki::Printer.new([:clipboard, :stdout])
    vpr.object = v.shows.parsed_response["films"]
    vpr.tabular
    vpr.pretty_ruby
    vpr.pretty_json

Clipboard output is only for Mac, for now.

### Command Line

    $ rviki shows
    $ rviki shows_item 50
    $ rviki shows_item 50 es
    $ rviki shows -f pretty_json 50
    $ rviki shows -o clipboard,stdout 50


