import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    //MARK: - Routes
//    app.get("movies") { req -> String in
//        return "Movies"
//    }
   
    //MARK: - Groupes
//    let moviesGroup = app.grouped("movies")
//
//    moviesGroup.get("comedy") { Request in
//        return "Comedy movies"
//    }
//
//    moviesGroup.get("romance") { Request in
//        return "Romance movies"
//    }
    
    //MARK: - Parameters
    app.get("movies", ":genre") { req -> String in
        guard let genre = req.parameters.get("genre") else { return "Invalid Genre" }
        return "Genre is \(genre)"
    }
//
//    app.get("movies", "year", ":year") { req -> String in
//        guard let year = req.parameters.get("year") else {
//            return "Invalid year"
//        }
//        return "Movie year is \(year)"
//    }

    //MARK: - POST Request
    app.post("movies") { req -> MoviesResponse in
        let movieRequest = try req.content.decode(MoviesRequest.self)
        
        if movieRequest.genre == "action" || movieRequest.genre == "comedy" {
            return getMoviesArr(genre: movieRequest.genre)
        } else {
            return MoviesResponse(status: 400, movies: [])
        }
    }

    func getMoviesArr(genre:String) -> MoviesResponse {
        // movies arr in database
        let actionMovies = ["The Dark Knight ", "The Lord of the Rings: The Return of the King", "Inception", "The Lord of the Rings: The Fellowship of the Ring", "The Mountain II"]

        let comedyMovies = ["The Chaos Class", "Parasite", "Life Is Beautiful", "The Intouchables", "Back to the Future"]

        // fetch operation from database
        var movies = actionMovies
        if genre == "comedy" {
            movies = comedyMovies
        } else {
            movies = actionMovies
        }

        let movieObject = MoviesResponse(status: 201, movies: movies)

        return movieObject
    }
    
    app.post("comments") { req -> CommentsResponse in
        let commentData = try req.content.decode(CommentsRequest.self)
        return CommentsResponse(status: 202, comment: commentData.description)
    }
}

struct MoviesRequest : Content {
    let genre : String
}

struct MoviesResponse : Content {
    let status : Int
    let movies : [String]
}

struct CommentsRequest : Content {
    let description: String
}

struct CommentsResponse : Content {
    let status: Int
    let comment: String
}
