library(metaPsychometric)
library(tidyverse)

ex1_meta_data <- read_csv("meta_data_ex1.csv")
ex1_results <- meta_bare_bones(ex1_meta_data)
print(ex1_results)

#now we make a funnel plot
meta_plot_funnel(ex1_results)
#the bars indicate the edges of the expected sampling distribution based on the meta-analytic mean

#EXAMPLE 2 - 30 studies
ex2_meta_data <- read_csv("meta_data_ex2.csv")
ex2_results <- meta_bare_bones(ex2_meta_data)
print(ex2_results)
meta_plot_funnel(ex2_results)

#EXAMPLE 3 - more complex data
ex3_meta_data <- read_csv("meta_data_ex3.csv")
ex3_results <- meta_bare_bones(ex3_meta_data)
print(ex3_results)
#due to moderators, the correlation could be as low as .265 and as high as .525
# only 12% of the error is due to sampling - means we should look for moderators
meta_plot_forest(ex3_results)
meta_plot_funnel(ex3_results)
#this bounds the range where the study correlations would be non-significant
meta_plot_funnel(ex3_results, show_null_dist = TRUE)

#maybe country is a moderator, SO we separate it
ex3_meta_data_canada <- ex3_meta_data %>% filter(country=="Canada")
ex3_meta_data_usa <- ex3_meta_data %>% filter(country=="United States")

#Canada analysis
ex3_results_canada <- meta_bare_bones(ex3_meta_data_canada)
print(ex3_results_canada)
#now it looks like all the variation is due to sampling error! distinct from the US
meta_plot_forest(ex3_results_canada)

#US analysis
ex3_results_usa <- meta_bare_bones(ex3_meta_data_usa)
print(ex3_results_usa)
meta_plot_forest(ex3_results_usa)


#EXAMPLE 4 - correcting for unreliability
ex4_meta_data <- read_csv("meta_data_ex4.csv")
#there are columns indicating the reliability of the measures in each study
ex4_results <- meta_corrected(ex4_meta_data)
print(ex4_results)

#now lets do this for each country
ex4_meta_data_canada <- ex4_meta_data %>% filter(country=="Canada")
ex4_meta_data_usa <- ex4_meta_data %>% filter(country=="United States")

ex4_results_canada <- meta_corrected(ex4_meta_data_canada)
print(ex4_results_canada)

ex4_results_usa <- meta_corrected(ex4_meta_data_usa)
print(ex4_results_usa)

#doesn't look like we do have evidence anymore for a moderating effect of country, there's still issues
#with the corrected meta analysis