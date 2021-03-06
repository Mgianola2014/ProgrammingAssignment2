## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
        m <- NULL ## Creates variable in local environment
        
        set <- function(y) {
                x <<- y  ## Supperassigns value of y to x, where x is makeVector()'s input
                m <<- NULL  ## If set() is called, a new vector will be stored in x, replacing the 
                ## existing value
        }
        
        get <- function() x  ## This can be called to retrieve the values of x from makeVector.
        ## cachemean will call on this function to provide it with values 
        ## needed for computation 
        
        setmean <- function(mean) m <<- mean ## This sets m to mean in the parent env (makeVector())
        
        getmean <- function() m  ## R will look for the value of m in getmean()        
        ## R won't find one within getmean, so it'll look         
        ## to the parent environment makeVector for m value
        
        
        list(set = set, ## This is needed to make functions public
             get = get, ## Essentially, this allows these functions to be called
             setmean = setmean, ## outside the local environment
             getmean = getmean
        )
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        
        #m <- x$getmean()          ## This calls the getmean() function from x. x is a container environment that
        m <- solve(x)
        ## consists of a list of functions and variables defined in the makeVector() environment.
        
        
        if(!is.null(m)) {               ## This checks if m has an existing value. If TRUE, then return that value.
                
                message("getting cached data")
                
                return(m)              ## If there's no existing value, this function will calculate it below
                
        }
        
        data <- x$get()              ## Calls get() function from x, which won't have an m value
        
        print(data)
        m <- mean(data, ...)      ## Computes mean from the retrieved values via x$get()
        
        
        x$setmean(m)              ## With the new mean, setmean() will be called to to update m in makeVector()
        
        
        m                                ## Prints the new matrix
        
}
