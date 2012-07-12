appstack
========

Feed it a yaml file; install everything.  

`appstack example.yml`  

appstack is a tool which will install OS X apps based on what it finds
in a yaml file. It can handle apps installed via command line, [app](https://github.com/suderman/app), [Homebrew](http://mxcl.github.com/homebrew/), and [npm](http://npmjs.org/). If those tools are missing, appstack can be configured to install them first. 

See 
[example.yml](https://github.com/suderman/appstack/blob/master/example.yml) to get an idea of how it works.  

Install
-------
Open a terminal and run this command:  

`curl https://raw.github.com/suderman/appstack/master/install.sh | sh`  

### Or, clone the repo
Download and copy `appstack` somewhere in your path, ie: 

`git clone https://github.com/suderman/appstack.git`  
`cp appstack/appstack /usr/local/appstack`  

Usage
-----
This tool is only as useful as the yaml file you set up. appstack
expects a big hash, with every key identifying each app. The value of
each key should be another hash, declaring which installer to use,
options to pass, commands to run before/after, and app prerequisites.  

Here's complex example using [Homebrew](http://mxcl.github.com/homebrew/):  

```
php53: 
  use: brew 
  opt: --with-mysql --with-cgi
  tap: josegonzalez/homebrew-php
  run: |
    echo "These commands get run after "
    echo "a successful installation!"
```

Often, you only need to be this verbose when including post-install
commands. If we took those out, the above example could be rewritten to
one line:  

`php53: brew --with-mysql --with-cgi josegonzalez/homebrew-php`  

Installing with [npm](http://npmjs.org/) is just as easy:

`coffee-script: npm`  

However, you'll need to expand the syntax to its longer form if you
wish to include other options, like `run` or `pre`. `pre` is like `run`,
except those commands get executed before the install. Alternatively, it
can also be used to pre-require any apps before installing the current one.  

Here's a long-form npm install, with `pre`:

```
uglify-js: 
  use: npm
  pre: [coffee-script, underscore]
```

The simplest apps to install use no tools other than the command line.
This example installs "app":  

`app: curl https://raw.github.com/suderman/app/master/install.sh | sh`  

[app](https://github.com/suderman/app) is an OS X installer which handles 
files ending in zip, dmg, app, pkg, mpkg, and safariextz. It can handle local 
files and URLs (just make sure the path ends with the actual filename and 
extension).

Here's an example installing Google Chrome:  

`Google Chrome.app: https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg`

It can also handle Mac App Store links (although the actual installation
of them is not scriptable):  

`Reeder.app: http://itunes.apple.com/ca/app/reeder/id439845554?mt=12`

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
