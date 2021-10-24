### Introduction

You have consumed few Apis till now and understand how to get and parse the response from the server. In this session we are going to learn about HTTP requests, how to create your own REST api with a local server setup. Yes we are going to create a local server on your Mac, sounds interesting ? Well lets make it more fun, you can setup the server right from your xcode with Swift. No need to learn any other language like Javascript or Python and no need to use another IDE. We are going to use Vapor which is a HTTP web framework written in Swift.  It makes writing your server side code from xcode easy and expressive. Vapor has Non-blocking, event-driven architecture built on top of Apple's [SwiftNIO](https://github.com/apple/swift-nio). The Vapor project includes over a hundred [official](https://github.com/vapor) and [community](https://github.com/vapor-community) maintained server-first Swift packages. Well if you are already pumped for getting started with vapor, lets go straight to installation...

### Installation

To use vapor on macOS, you need swift version 5.2 or greater which comes bundled with xcode you already installed. (Make sure you check the latest requirements from vapor documentation [here](https://docs.vapor.codes/4.0/install/macos/ before setup)). You can check the version of swift with :-

```
swift --version
```

You may see an output like following:-

```
Apple Swift version 5.5 (swiftlang-1300.0.31.1 clang-1300.0.29.1) Target: x86_64-apple-darwin20.6.0
```

Now we are ready to install vapor. To install vapor we are going to use Homebrew. Its a package manager which helps installing packages like vapor. Check if you have homebrew already installed with `brew help`. If brew is there, you get output. If not, you get 'command not found'. If you dont have homebrew installed just follow the commands [here](https://brew.sh). If you still not clear you can check this [video](https://www.youtube.com/watch?v=SOjSNB7F2m4).

If you have homebrew installed run the following command:-

```
brew install vapor
```

Double check to ensure that the installation was successful by printing help.

```
vapor --help
```

You should see a list of available commands as follows:

```
Usage: vapor <command>
Vapor Toolbox (Server-side Swift web framework)
Commands:

build - Builds an app in the console.
clean - Cleans temporary files.
        heroku Commands for working with Heroku
  new - Generates a new app.
  run - Runs an app from the console. 
        Equivalent to `swift run --enable-test-discovery Run`.         
supervisor - Commands for working with Supervisord
xcode - Opens an app in Xcode.

Use `vapor <command> [--help,-h]` for more information on a command.
```
