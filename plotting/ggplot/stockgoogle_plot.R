library(Quandl)
library(ggplot2)

data_series <- Quandl("GOOG/NASDAQ_AAPL", start_date="2005-01-01")[,c(1,5)]

my.plot <- ggplot(data = data_series, aes(x = Date, y = Close)) +
            geom_line(color = "#FAB521") +
            theme(panel.background = element_rect(fill="#393939"),
                  panel.grid.major.x = element_blank(),
                  panel.grid.major.y = element_line(colour = 'white', size = 0.1),
                  panel.grid.minor = element_line(colour = 'white', size = 0.1)) +
            xlab("Date") +
            ylab("Closing Price") +
            ggtitle("AAPL")


my.plot
