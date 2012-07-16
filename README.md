appstack
========

Feed it yaml; install everything.  

`appstack example.yml`  

appstack is a tool which will install OS X apps based on what it finds
in a yaml file. It will happily skip over installed apps and so can be 
safely run again and again. appstack can handle apps installed via command line, 
[app](https://github.com/suderman/app), 
[Homebrew](http://mxcl.github.com/homebrew/), and [npm](http://npmjs.org/). 
And if those tools are missing, the yaml file can be configured to install them first.  

See 
[example.yml](https://github.com/suderman/appstack/blob/master/example.yml) to get an idea of how it works.  

Install
-------
Open a terminal and run this command:  

`curl https://raw.github.com/suderman/appstack/master/install.sh | sh`  

### Or, clone the repo
Download and copy `appstack` somewhere in your path, ie: 

`git clone https://github.com/suderman/appstack.git`  
`cp appstack/appstack /usr/local/bin`  

Usage
-----
This tool is only as useful as the yaml file you set up.  

appstack expects a big hash, with every key identifying each app. The value of
each key should be another hash, declaring which installer to use,
options to pass, commands to run before/after, and app prerequisites.
However, a single string can often be used as a short-form alternative to the
hash.

###Basic Usage
The simplest apps to install use no tools other than the command line.
This example installs [app](https://github.com/suderman/app):  

`app: curl https://raw.github.com/suderman/app/master/install.sh | sh`  

###Usage with Hombrew
Here's complex example using [Homebrew](http://mxcl.github.com/homebrew/):  

```
php53: 
  use: brew 
  opt: --with-mysql --with-cgi
  tap: josegonzalez/php
  run: |
    echo "These commands get run after "
    echo "a successful installation!"
```

Often, you only need to be this verbose when including post-install
commands. If we took those out, the above example could be rewritten to
one line:  

`php53: brew --with-mysql --with-cgi josegonzalez/php`  

###Usage with npm
Installing with [npm](http://npmjs.org/) is just as easy:

`coffee-script: npm`  

However, you'll need to expand the syntax to its longer form if you
wish to include other options, like `run` or `pre`. `pre` is like `run`,
except those commands get executed before the install. Alternatively, it
can also be used to pre-require any apps before installing the current one.  

Here's a long-form [npm](http://npmjs.org/) install, with `pre`:

```
uglify-js: 
  use: npm
  pre: [coffee-script, underscore]
```

###Usage with app
[app](https://github.com/suderman/app) is an OS X installer which handles 
files ending in zip, dmg, app, pkg, mpkg, and safariextz. It can handle local 
files and URLs (just make sure the path ends with the actual filename and 
extension).

Here's an example installing Dropbox, with a post-install command:  

```
Dropbox.app: 
  use: https://ddr3luum8vl5r.cloudfront.net/Dropbox%201.4.9.dmg
  run: mv -f /Applications/Dropbox.app/Contents/Resources/check.icns /Applications/Dropbox.app/Contents/Resources/check.icns.bak
```

This is a single line example which installs Google Chrome:  

`Google Chrome.app: https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg`

It can also handle Mac App Store links (although the actual installation
of them is not scriptable):  

`Reeder.app: macappstore://itunes.apple.com/ca/app/reeder/id439845554?mt=12`

Check [example.yml](https://github.com/suderman/appstack/blob/master/example.yml) for more information on what can be done.

###Bootstrap
appstack will process the yaml file alphabetically, but some apps really
ought to installed before everything else. In your yaml file, include a
line with array of apps, and those will be addresed in that order:  

`bootstrap: [app, llvm-gcc, gcc, brew, node, npm]`  

Options
-------
If you only want to check your yaml file without actually installing
anything, you can pass the -c option:

`appstack -c example.yml`  

appstack is polite and won't overwrite existing apps without
asking. You can skip this check by passing the -f option:  

`appstack -f example.yml`  
