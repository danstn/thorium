#![alt text](https://cdn0.iconfinder.com/data/icons/typicons-2/24/th-small-32.png "Th90") Thorium

[![Gem Version](http://img.shields.io/gem/v/thorium.svg)][gem]
[![Build Status](https://travis-ci.org/dzotokan/thorium.svg?branch=master)](https://travis-ci.org/dzotokan/thorium)
[![Code Climate](https://codeclimate.com/github/dzotokan/thorium/badges/gpa.svg)](https://codeclimate.com/github/dzotokan/thorium)
[![Dependency Status](https://gemnasium.com/dzotokan/thorium.svg)](https://gemnasium.com/dzotokan/thorium)


[gem]: https://rubygems.org/gems/thorium

Simple workflow automation toolkit.

Ruby 2.0 is needed.

## Installation

    gem install thorium
    
With an alias included (optional):

    gem install thorium && alias th=thorium
    
## Updates

    gem update thorium    

## Usage

### Common

List local public keys and prompt to generate a new one if none are present

    thorium pubkeys
    
Copy the default `~/.ssh/id_rsa.pub` to your clipboard

    thorium pubkey                                                                                               

#### Example

    $ thorium pubkey                                  
    Use `thorium pubkeys` if you want to select a specific key.
    ---> `~/.ssh/id_rsa.pub` copied to your clipboard.

### Github CLI

List github repositories for a user

    thorium git list

List and clone github repositories for a user

    thorium git clone

Pull a project-specific `.gitignore` file into current directory

    thorium git ignore
    
#### Example

```
$ thorium git ignore                                                                                                
Fetching a list of gitignore files...
-------------------------------------
[1] Actionscript            [2] Ada                     [3] Agda                    [4] Android                 [5] AppceleratorTitanium
[6] ArchLinuxPackages       [7] Autotools               [8] C++                     [9] C                       [10] CFWheels
[11] CMake                  [12] CONTRIBUTING           [13] CakePHP                [14] ChefCookbook           [15] Clojure
[16] CodeIgniter            [17] CommonLisp             [18] Composer               [19] Concrete5              [20] Coq
[21] CraftCMS               [22] DM                     [23] Dart                   [24] Delphi                 [25] Drupal
...
Which file would you like to copy? (Enter to skip) 8
      create  .gitignore
```
    
### Runcom (rc files)

#### All

Run all runcom tasks: `vim`, `sqlite`

    thorium runcom all

#### Vim

Update `.vimrc` with some essential options

    thorium runcom vim
   
Default options:
```
syntax on
```

#### SQLite
    
Update `.sqliterc` with some essential options

    thorium runcom sqlite

Default options:    
```
.headers ON
.mode column
```    
    
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
