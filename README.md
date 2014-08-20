#![alt text](https://cdn0.iconfinder.com/data/icons/typicons-2/24/th-small-32.png "Th90") Thorium

[![Gem Version](http://img.shields.io/gem/v/thorium.svg)][gem]
[![Code Climate](https://codeclimate.com/github/dzotokan/thorium/badges/gpa.svg)](https://codeclimate.com/github/dzotokan/thorium)
[![Dependency Status](https://gemnasium.com/dzotokan/thorium.svg)](https://gemnasium.com/dzotokan/thorium)


[gem]: https://rubygems.org/gems/thorium

Simple workflow automation toolkit.

## Installation

    gem install thorium
    
## Updates

    gem update thorium    

## Usage

### Common

List local public keys and prompt to generate a new one if none are present

    thorium pubkeys

### Git CLI

List github repositories for a user

    thorium git list

List and clone github repositories for a user

    thorium git clone
  
### Apache CLI
  
Generic apache controller.
Run `thorium apache` for more information.

## Documentation

    thorium help

License
-------
Code is under the GPL3 license.
