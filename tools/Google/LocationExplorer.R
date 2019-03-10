# T Hollis (CSC2552, University of Toronto) -v2.1
#     - Purpose: Analyse Google's GDPR location data
#     - Bugs & issues: no bugs, no issues, no warnings

# Step 0. Load packages required
library("jsonlite")
library("ggmap")
library("sp")
library("leaflet")
library("ggplot2")
library("RgoogleMaps")
library("maps")
library("mapdata")
library("maptools")
library("lubridate")
library("zoo")

# Step 1. Import JSON location history & convert to dataframe
location_data <- fromJSON("Location History.json", flatten=TRUE)
dt_location_data <- data.table(location_data$locations)

# Step 2. Convert from weird google formats to standard formats
data <- location_data$locations
data$time <- as.POSIXct(as.numeric(data$timestampMs)/1000, origin = "1970-01-01") #convert from POSIX ms to POSIX readable
data$lat <- loc$latitudeE7/1e7 # convert from E7 coords to GPS
data$lon <- loc$longitudeE7/1e7 # convert from E7 coords to GPS

# Step 3. EDA (courtesy of Shirin Glander at https://shiring.github.io/maps/2016/12/30/Standortverlauf_post)
total_logged_locations <- nrow(data)
earliest_log <- min(data$time)
latest_log <- max(data$time)

data$date <- as.Date(data$time, '%Y/%m/%d')
data$year <- year(data$date)
data$month_year <- as.yearmon(data$date)

days_logged <- data.frame(table(data$date), group = "day")
nrow(days_logged)
months_logged <- data.frame(table(data$month_year), group = "month")
nrow(months_logged)
years_logged <- data.frame(table(data$year), group = "year")
nrow(years_logged)

# Step 4. Plotting the data (courtesy of Shirin Glander at https://shiring.github.io/maps/2016/12/30/Standortverlauf_post)

# 4.1 Logging stats
my_theme <- function(base_size = 12, base_family = "sans"){
  theme_grey(base_size = base_size, base_family = base_family) +
    theme(
      axis.text = element_text(size = 12),
      axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
      axis.title = element_text(size = 14),
      panel.grid.major = element_line(color = "grey"),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = "aliceblue"),
      strip.background = element_rect(fill = "lightgrey", color = "grey", size = 1),
      strip.text = element_text(face = "bold", size = 12, color = "navy"),
      legend.position = "right",
      legend.background = element_blank(),
      panel.margin = unit(.5, "lines"),
      panel.border = element_rect(color = "grey", fill = NA, size = 0.5)
    )
}

points <- rbind(days_logged[, -1], months_logged[, -1], years_logged[, -1])

ggplot(points, aes(x = group, y = Freq)) +
  geom_point(position = position_jitter(width = 0.2), alpha = 0.3) +
  geom_boxplot(aes(color = group), size = 1, outlier.colour = NA) +
  facet_grid(group ~ ., scales = "free") + my_theme() +
  theme(
    legend.position = "none",
    strip.placement = "outside",
    strip.background = element_blank(),
    strip.text = element_blank(),
    axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5)
  ) +
  labs(
    x = "",
    y = "Number of data points",
    title = "How many data points did Google collect about me?",
    subtitle = "Number of data points per day, month and year",
    caption = "\nGoogle collected between 0 and 150 data points per day (median ~10),
    between 0 and 1200 per month (median ~300) and
    between 0 and 2,000 per year (median ~500)."
  )

# 4.2 Accuracy stats

accuracy <- data.frame(accuracy = data$accuracy, group = ifelse(data$accuracy < 800, "high", ifelse(data$accuracy < 5000, "middle", "low")))

accuracy$group <- factor(accuracy$group, levels = c("high", "middle", "low"))

ggplot(accuracy, aes(x = accuracy, fill = group)) +
  geom_histogram() +
  facet_grid(group ~ ., scales="free") +
  my_theme() +
  theme(
    legend.position = "none",
    strip.placement = "outside",
    strip.background = element_blank(),
    axis.text.x = element_text(angle = 0, vjust = 0.5, hjust = 0.5)
  ) +
  labs(
    x = "Accuracy in metres",
    y = "Count",
    title = "How accurate is the location data?",
    subtitle = "Histogram of accuracy of location points",
    caption = "\nMost data points are pretty accurate,
    but there are still many data points with a high inaccuracy.
    These were probably from areas with bad satellite reception."
  )

# 4.3 Country-level data

UK <- get_map(location = 'United Kingdom', zoom = 5)

ggmap(UK) + geom_point(data = data, aes(x = lon, y = lat), alpha = 0.5, color = "red") +
  theme(legend.position = "right") +
  labs(
    x = "Longitude",
    y = "Latitude",
    title = "Location history data points in Europe",
    caption = "\nA simple point plot shows recorded positions.")

# 4.4 City-level data

london <- get_map(location = 'London', zoom = 12)

options(stringsAsFactors = T)
ggmap(london) +
  stat_summary_2d(geom = "tile", bins = 100, data = data, aes(x = lon, y = lat, z = accuracy), alpha = 0.5) +
  scale_fill_gradient(low = "blue", high = "red", guide = guide_legend(title = "Accuracy")) +
  labs(
    x = "Longitude",
    y = "Latitude",
    title = "Location history data points around London",
    subtitle = "Color scale shows accuracy (low: blue, high: red)",
    caption = "\nThis bin plot shows recorded positions
    and their accuracy in and around London")

# 4.5 Velocity data

data_2 <- data[which(!is.na(data$velocity)), ]

london <- get_map(location = 'London', zoom = 10)

ggmap(london) + geom_point(data = data_2, aes(x = lon, y = lat, color = velocity), alpha = 0.3) +
  theme(legend.position = "right") +
  labs(x = "Longitude", y = "Latitude",
       title = "Location history data points in London",
       subtitle = "Color scale shows velocity measured for location",
       caption = "\nA point plot where points are colored according
       to velocity") +
  scale_colour_gradient(low = "blue", high = "red", guide = guide_legend(title = "Velocity"))
