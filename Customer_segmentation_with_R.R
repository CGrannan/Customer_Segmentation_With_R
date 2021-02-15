library(tidyverse)
library(readr)
library(broom)
data = read_csv('Mall_Customers.csv')

head(data)
summary(data)

names(data)[names(data) == "Annual Income (k$)"] <- "annual_income"
names(data)[names(data) == "Spending Score (1-100)"] <- "spending_score"


# Check for duplicate rows
data[duplicated(data), ]

test_km <- kmeans(data[,3:5], centers = 3, nstart = 50)
test_km
glance(test_km)

tibble(clusters = 1:20) %>% 
  mutate(mod = map(clusters, ~ kmeans(data[,3:5], centers = .x, nstart = 50))) %>%
  mutate(glanced = map(mod, glance)) %>%
  unnest(glanced) %>%
  ggplot(aes(x=clusters, y = tot.withinss/totss)) +
  geom_line()

test_km <- kmeans(data[,3:5], centers = 10, nstart = 50)
test_km
glance(test_km)

ggplot(data, aes(x = spending_score, y = annual_income)) + 
  geom_point(stat = "identity", aes(color = as.factor(test_km$cluster))) +
  scale_color_discrete(name=" ",
                       breaks=c("1", "2", "3", "4", "5","6"),
                       labels=c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5","Cluster 6")) +
  ggtitle("Segments of Mall Customers", subtitle = "Using K-means Clustering")
