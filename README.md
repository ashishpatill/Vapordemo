# How to use vapor to create your own api with Swift

## Introduction

You have consumed few Apis till now and understand how to get and parse the response from the server. In this session we are going to learn about HTTP requests, how to create your own REST api with a local server setup. Yes we are going to create a local server on your Mac, sounds interesting ? Well lets make it more fun, you can setup the server right from your xcode with Swift. No need to learn any other language like Javascript or Python and no need to use another IDE. We are going to use Vapor which is a HTTP web framework written in Swift.  It makes writing your server side code from xcode easy and expressive. Vapor has Non-blocking, event-driven architecture built on top of Apple's [SwiftNIO](https://github.com/apple/swift-nio). The Vapor project includes over a hundred [official](https://github.com/vapor) and [community](https://github.com/vapor-community) maintained server-first Swift packages. Well if you are already pumped for getting started with vapor, lets go straight to installation...

## Installation

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
## Setup Vapor project

Now that you have vapor installed lets create a vapor project. Open Terminal and navigate to the project folder where you want to create your new project. 

```
cd <Path to your project directory> 
```

Create a new project

```
vapor new projectName -n
```

> The `-n` flag gives you a bare bones template by automatically answering no to all questions.

Once the command finishes, change into the newly created folder:

```
cd projectName
```
## Folder Structure

Vapor follows SPM (Swift package manager's) folder structure. So it might feel lot familiar to you. 

![Vapor Folder structure](https://i.imgur.com/WqN2wUW.png)


This is how your folder structure looks like. Some of the important folders and files are explained below:

### Public folder 

All public accessible files like any public browser scripts, public images etc are kept in this folder. You will need to enable fileMiddleware if you want one in configure file.

```swift
// Serves files from `Public/` directory
let fileMiddleware = FileMiddleware(
    publicDirectory: app.directory.publicDirectory
)
app.middleware.use(fileMiddleware)

```
### Sources folder
As the name says it contains all the source code for project.

App folder:
This is where you should put all your logic and non public code.

### Controller folder

This folder contains all the controllers for your vapor project. You can create a controller to represent a bunch of Apis as per their functionality. e.g. A Login controller might have a login and register api. It may also manage connections and operrations with database for those apis. By default vapor project follows the MVC (Model view controller design pattern)

### Configure file

This file contains the configuration details of project like routes, databases, providers, etc. It contains a `configure(_:)` function which is called by `main.swift`.

### routes.swift file

This file contains the `routes(_:)` function. This file contains the logic for Api. The routes function handles the redirection, processing the request and returning the response for the route. You can register sub-routes for a route. The Routes function is called from `configure(_:)` function.

You can check details about other folder details [here](https://docs.vapor.codes/4.0/folder-structure/).

## Build & Run

### Xcode

First, open the project in Xcode:

```
open Package.swift
```

you can either use 

```
vapor xcode
```

It will automatically start downloading the package dependencies as follows: -

![Vapor Package Dependencies](https://i.imgur.com/GVYq3Wi.png)

You can run your project now with xcode. or you can run it from terminal with 

```
swift run
```

The first time you run this it will take some time to fetch and resolve the dependencies. Once running you should see the following in your console:

```
[ INFO ] Server starting on http://127.0.0.1:8080
```

you can now go to your browser and open [http://127.0.0.1:8080](http://127.0.0.1:8080) or http://localhost:8080

You may see the message in browser saying

```
It works!
```

This means our local server is up and running. We can now build an api on our local server.

## Creating an Api

### Routing

What do mean by Routing is that we receive the information in the form a request, process that information and return a response. This process may involve finding the correct request handler for the request, getting the information from parameters or request body or fetching some info from the database, process the info and return a response in desired format (usually JSON).

Lets look at a sample request:-

~~~
GET /hello/vapor HTTP/1.1
host: vapor.codes
content-length: 0
~~~

This is a simple HTTP request of type `GET`. 

## Basics of HTTP Request

An HTTP request mainly consists of:

- HOST and Request path
- HTTP Methods
- Parameters, query string
- Request Body

### HOST and Request path
A request host is the first part of URL, usually the domain. e.g.  `https://www.youtube.com/channel/FGHJTTJgadhdfKAHF4msZN`. Here www.youtube.com is the domain or host path of your Request. After `/` is the request path. `channel` is the route which accepts an encrypted string holding information about the channel.

### HTTP Methods

HTTP methods help distinguish the type of request we want to make. It can be classified like CRUD operations.

There are 5 main types of an HTTP request methods as follows:

![HTTP methods](https://i.imgur.com/UMvXCRm.png)

As mentioned above, `GET` performs the read operation on your server database and returns the desired result. `POST` creates an object and saves in your server database. So your method type determines what kind of operation you want to perform.

You can check details of an HTTP request [here](https://www.tutorialspoint.com/http/http_requests.htm).

### Parameters

You can add parameters to your request URL. 
e.g. https://www.youtube.com/channel/FGHJTTJgadhdfKAHF4msZN 
Here after your `channel/` you can find the parameter `FGHJTTJgadhdfKAHF4msZN`. You can accept the parameter value, use it to provide the response. 

### Request Body

In Request body you will pass data in the form of an json encoded object.

## Creating a Request with Vapor

### Default Route
Lets look at the routing.swift file. You can see following get request:

~~~swift
app.get { req in
   return "It works!"
}
~~~

This method is not accepting any parameters yet and returning a string response. Try changing the string, run your project again and reload your browser. You will see updated text in your browser.

### Creating a new Route without a parameter

Lets create another route called movies: 

~~~swift 
app.get("movies") { req -> String in
    return "This will return a list of movies"
}
~~~

 The get() method accepts string as parameters. The first string parameter here is name of the route. The get() method returns a completion handler along with a request object as parameter. You can specify the return type of your response like: 
 
~~~swift
-> String
~~~

Now try opening this url in browser : http://localhost:8080/movies. You will see response string `Movies` in your browser.

### Route with a parameter

Instead of creating a new route for each response, we can accept the route as a parameter and process it to return a response as needed by the parameter.

~~~swift
app.get("movies", ":genre") { req -> String in
    guard let genre = req.parameters.get("genre") else { return "Invalid Genre" }
    if genre == "comedy" {
        return "Hangover, Home alone"
    } else {
        return "please specify the correct genre"
    }
    return "Genre is \(genre)"
}
~~~ 

Here we accept `genre` as the parameter for the genre of movies. If value for the parameter is "**comedy**" we will return a string with some movie names otherwise just ask user to add the valid `genre`. So you can see how you can use the parameters.

You can return a custom json object as response you have to return type. 

Following Json object contains an array of movie objects:

~~~swift
{
	"status" : 200
	"movies" : [
		{
			"title": "movie 1",
			"id": 2,
			"director": "ABC"
		},			
		{
			"title": "movie 2",
			"id": 263,
			"director": "PQR"
		},
		{
			"title": "movie 3",
			"id": 349,
			"director": "XYZ"
		}
	]
}
~~~

To return this json object as the response you will need to create a struct representing the movie api response as follows:

~~~swift
struct MovieResponse: Content {
	let status: String
	let movies: [Movie] 
}

struct Movie: Content {
	let title: String 
	let id: Int
	let director: String 
}  
~~~ 

Now our `app.get()` method can return `MovieResponse` object instead of a string. Notice that MovieResponse confirms to the `Content` protocol. Content protocol helps encode the api response json to MovieResponse object. It uses the codable protocol to do this. 

~~~swift
app.get("movies") { req -> MoviesResponse in
	let movieArr = ["Movie 1", "Movie 2", "Movie 3", "Movie 4", "Movie 5"]	
	let movieObject = MoviesResponse(status: 201, movies: movieArr)
   	return movieObject
}
~~~

Now our /movies endpoint returns the movie object which contains array of movies. 

### Handle POST request
POST request as discussed earlier has a body which can accept an object as input. So we will create a struct for MovieRequest.

~~~swift
struct MoviesRequest : Content {
    let category : String
}
~~~ 

Now create a movie request object in your app or you can use a client like postman to pass the request object with category. 

~~~swift 
let request = MoviesRequest(category: "action")
~~~

Now when you send a post request, you will receive this request object. So we will now add code to get the incoming request. Process it and then return the MovieResponse object.

~~~swift
app.post("movies") { req -> MoviesResponse in
    let movieRequest = try req.content.decode(MoviesRequest.self)
    
    if movieRequest.category == "action" || movieRequest.category == "comedy" {
    	return getMoviesObject(category: movieRequest.category)
    } else {
    	// error response
    	return MoviesResponse(status: 400, movies: [])
    }
}

// Returns a movie response object which contains array of movies
func getMoviesObject(category:String) -> MoviesResponse {
    // movies arr in database
    let actionMovies = ["The Dark Knight ", "The Lord of the Rings: The Return of the King", "Inception", "The Lord of the Rings: The Fellowship of the Ring", "The Mountain II", "300"]

    let comedyMovies = ["The Chaos Class", "Parasite", "Life Is Beautiful", "The Intouchables", "Back to the Future"]

    // fetch operation from database
    var movies = actionMovies
    if category == "comedy" {
        movies = comedyMovies
    } else {
        movies = actionMovies
    }

    let movieObject = MoviesResponse(status: 201, movies: movies)
    return movieObject
}
~~~

Thats it you have now created a POST Api in your Xcode with swift. Cant be more convinient than that. So play along and try to create some custom request.
