#![alt text](https://cdn0.iconfinder.com/data/icons/typicons-2/24/th-small-32.png "Th90") Thorium

[![Gem Version](http://img.shields.io/gem/v/thorium.svg)][gem]
[![Build Status](https://travis-ci.org/dzotokan/thorium.svg?branch=master)](https://travis-ci.org/dzotokan/thorium)
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

### Github CLI

List github repositories for a user

    thorium git list

List and clone github repositories for a user

    thorium git clone
    
#### Example

    $ thorium git clone
    Enter Github username:  git

    Fetching Github repositories (git)...
    ------------------------------------------
    [1]  git            git@github.com:git/git.git            https://github.com/git/git.git
    [2]  git-reference  git@github.com:git/git-reference.git  https://github.com/git/git-reference.git
    [3]  git-scm.com    git@github.com:git/git-scm.com.git    https://github.com/git/git-scm.com.git
    [4]  git.github.io  git@github.com:git/git.github.io.git  https://github.com/git/git.github.io.git
    [5]  gitscm-old     git@github.com:git/gitscm-old.git     https://github.com/git/gitscm-old.git
    [6]  hello-world    git@github.com:git/hello-world.git    https://github.com/git/hello-world.git
    Which repository would you like to clone? (Enter to skip) [1, 2, 3, 4, 5, 6] 6
    Select a protocol (ssh or https)? [s, h] s
    
  
### Apache CLI
  
Generic apache controller.
Run `thorium apache` for more information.

## Documentation

    thorium help

License
-------
Code is under the GPL3 license.
