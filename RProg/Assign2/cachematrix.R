## The 'makeCacheMatrix' function will set a matrix value and cache the inverse

## set, sets the value of the matrix
## get, gets the value of the matrix
## setinverse, sets the value of the inverse
## getinverse, sets the value of the inverse

makeCacheMatrix <- function(x) {
       inverted <- NULL
       set <- function(y) {
           x <<- y
           inverted <<- NULL
       }
       get <- function() x
       setinverse <- function(inverse) inverted <<- inverse
       getinverse <- function() inverted
       list(set = set, get = get,
            setinverse = setinverse, 
            getinverse = getinverse)
}


## The 'cacheSolve' function checks for a cached inverse value of a matrix.
## If unavailable, the inverse value is calculated and set.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        inverted <- x$getinverse()
        if(!is.null(inverted)) {
                message("getting cached data")
                return(inverted)
        }
        
        data <- x$get()
        inverted <- solve(data)
        x$setinverse(inverted)
        inverted
}

## usage example:
## > m <- matrix(data = c(1,2,3,4), nrow =2, ncol = 2)
## > my_cache_matrix <- makeCacheMatrix(m)
## > my_cache_matrix$get
##      [,1] [,2]
## [1,]    1    3
## [2,]    2    4
##
## > cacheSolve(my_cache_matrix)
##      [1,] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5
##
## > cacheSolve(my_cache_matrix)
## getting cached data
##      [1,] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5
##
## on second cacheSolve call, cached data is retrieved