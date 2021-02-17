library(tidyverse)
library(readr)
library(broom)
data = read_csv('Mall_Customers.csv')

head(data)
summary(data)
# No missing values

names(data)[names(data) == 'Annual Income (k$)'] <- 'annual_income'
names(data)[names(data) == 'Spending Score (1-100)'] <- 'spending_score'


# Check for duplicate rows
data[duplicated(data), ]

# Plot Data
ggplot(data, aes(x = Gender)) + 
  geom_bar(fill = 'salmon1') + 
  labs(title = 'Gender Counts', x = 'Gender', y = 'Count')

ggplot(data, aes(x = Age)) +
  geom_bar(fill='lightseagreen') +
  scale_x_binned(n.breaks = 30) +
  labs(title = 'Age Counts', x = 'Age', y = 'Count')

ggplot(data, aes(x = Age)) +
  geom_density(fill='lightseagreen') + 
  labs(title = 'Age Density Plot', x = 'Age', y = 'Density')

ggplot(data, aes(x = Age, y = annual_income)) +
  geom_point(color = 'orangered') + 
  labs(title = 'Age by Annual Income', x = 'Age', y = 'Annual Income')

ggplot(data, aes(x = Age, y = spending_score)) +
  geom_point(color = 'orangered') +
  labs(title = 'Age by Spending Score', x = 'Age', y ='Spending Score')

ggplot(data, aes(x = annual_income, y = spending_score, color = Gender)) +
  geom_point() +
  labs(title = 'Annual Income by Spending Score',
       subtitle = 'Grouped by Gender',
       x= 'Annual Income', y = 'Spending Score')

# Elbow method to find number of clusters
tibble(clusters = 1:20) %>% 
  mutate(mod = map(clusters, ~ kmeans(data[,3:5], centers = .x, nstart = 50))) %>%
  mutate(glanced = map(mod, glance)) %>%
  unnest(glanced) %>%
  ggplot(aes(x=clusters, y = tot.withinss/totss)) +
  geom_line()

km_5_clusters <- kmeans(data[,3:5], centers = 5, nstart = 50)
km_5_clusters
glance(km_5_clusters)

ggplot(data, aes(x = spending_score, y = annual_income)) + 
  geom_point(stat = 'identity', aes(color = as.factor(km_5_clusters$cluster))) +
  scale_color_discrete(name=' ',
                       breaks=c('1', '2', '3', '4', '5'),
                       labels=c('Cluster 1', 'Cluster 2', 'Cluster 3', 
                                'Cluster 4', 'Cluster 5')) +
  labs(title = 'Segments of Mall Customers', 
       subtitle = 'Using K-means Clustering',
       x = 'Spending Score', y = 'Annual Income')

ggplot(data, aes(x = Age, y = annual_income)) + 
  geom_point(stat = 'identity', aes(color = as.factor(km_5_clusters$cluster))) +
  scale_color_discrete(name=' ',
                       breaks=c('1', '2', '3', '4', '5'),
                       labels=c('Cluster 1', 'Cluster 2', 'Cluster 3', 
                       'Cluster 4', 'Cluster 5')) +
  labs(title = 'Segments of Mall Customers', 
       subtitle = 'Using K-means Clustering',
       y = 'Annual Income')

ggplot(data, aes(x = Age, y = spending_score)) + 
  geom_point(stat = 'identity', aes(color = as.factor(km_5_clusters$cluster))) +
  scale_color_discrete(name=' ',
                       breaks=c('1', '2', '3', '4', '5'),
                       labels=c('Cluster 1', 'Cluster 2', 'Cluster 3', 
                                'Cluster 4', 'Cluster 5')) +
  labs(title = 'Segments of Mall Customers', 
       subtitle = 'Using K-means Clustering',
       y = 'Spending Score')

km_6_clusters <- kmeans(data[,3:5], centers = 6, nstart = 50)
km_6_clusters
glance(km_6_clusters)

ggplot(data, aes(x = spending_score, y = annual_income)) + 
  geom_point(stat = 'identity', aes(color = as.factor(km_6_clusters$cluster))) +
  scale_color_discrete(name=' ',
                       breaks=c('1', '2', '3', '4', '5','6'),
                       labels=c('Cluster 1', 'Cluster 2', 'Cluster 3',
                                'Cluster 4', 'Cluster 5', 'Cluster 6')) +
  labs(title = 'Segments of Mall Customers', 
       subtitle = 'Using K-means Clustering',
       x = 'Spending Score', y = 'Annual Income')

ggplot(data, aes(x = Age, y = annual_income)) + 
  geom_point(stat = 'identity', aes(color = as.factor(km_6_clusters$cluster))) +
  scale_color_discrete(name=' ',
                       breaks=c('1', '2', '3', '4', '5','6'),
                       labels=c('Cluster 1', 'Cluster 2', 'Cluster 3', 
                                'Cluster 4', 'Cluster 5', 'Cluster 6')) +
  labs(title = 'Segments of Mall Customers', 
       subtitle = 'Using K-means Clustering',
       y = 'Annual Income')

ggplot(data, aes(x = Age, y = spending_score)) + 
  geom_point(stat = 'identity', aes(color = as.factor(km_6_clusters$cluster))) +
  scale_color_discrete(name=' ',
                       breaks=c('1', '2', '3', '4', '5','6'),
                       labels=c('Cluster 1', 'Cluster 2', 'Cluster 3', 
                                'Cluster 4', 'Cluster 5', 'Cluster 6')) +
  labs(title = 'Segments of Mall Customers', 
       subtitle = 'Using K-means Clustering',
       y = 'Spending Score')
