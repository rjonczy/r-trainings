library(twitteR)

# setup twitter oauth
twitter_oauth_setup <- function() {
    ckey = "6Uhl5HJ19ll0J4TJSNY4XDHec"
    csec = "DeCJuI9iVTfT5z8992OLmwlDJ2pxhe8rZMvHeFHg8bSiMUEDgn"
    akey = "265526234-eWUnDMfz7FkljY4mDMiPHXwi6MqkI6vnNlCZ52uB"
    asec = "phesg3rFovsPNNrffSEs6PS6nzYGFTaZP69VNG7mmad0e"
    
    setup_twitter_oauth(ckey, csec, akey, asec)  
}

# create folder for data files
if(!file.exists('data')) {
    dir.create('data')
}

# Setup the login for this session
options(httr_oauth_cache = TRUE)
twitter_oauth_setup()

tweets <- userTimeline("RDataMining", n = 3200)
tweets.df <- twListToDF(tweets)
