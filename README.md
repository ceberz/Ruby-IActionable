# Overview #

Ruby IActionable is a straightforward wrapper for IActionable's restful API.  The JSON-encoded responses from IActionable are wrapped in objects that provide a few extra functions here and there, but are mostly just a representation of the API response.

# How To Use #

## Installation ##

    gem install ruby-iactionable

## IRB ##

    require 'iactionable'

## Bundler ##

    gem 'ruby-iactionable', :require => 'iactionable'

## API Credentials And Initialization ##

Before the API wrapper can be instantiated or used it must be pre-initialized with your IActionable credentials and version number (IActionable supports older versions but recommends staying up to date):

    IActionable::Api.init_settings( :app_key => "12345",
                                    :api_key => "abcde",
                                    :version => 3 )
    @api = IActionable::Api.new

The responses for each of the endpoints of IActionable's API are described through example by [their documentation](http://www.iactionable.com/api/).  Here is an example of the response from a [profile summary](http://iactionable.com/api/profiles/#getprofilesummary) returned as an object by the wrapper.

    profile_summary = @api.get_profile_summary("user", "username", "zortnac", 10)
    profile_summary.display_name # => "Chris Eberz"
    profile_summary.identifiers.first # => instance of IActionable::Objects::Identifier
    profile_summary.identifiers.first.id_type # => "username"
    profile_summary.identifiers.first.id # => "zortnac"

Each object can be dumped back in to its original form of arrays and key/value pairs:

    profile_summary.to_hash # => { "DisplayName" => "Chris Eberz", "Identifiers" => [ {"ID" => "zortnac", "IDType" => "username", ...} ] ... }
                            # (not shown in entirety)

----------------

## IActionable ##

[Visit their website!](http://www.iactionable.com)

## Author ##

Christopher Eberz; chris@chriseberz.com; @zortnac