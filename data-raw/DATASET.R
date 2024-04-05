## code to prepare `DATASET` dataset goes here

library(readxl)

s1 <- readxl::read_excel("C:/Users/conno/OneDrive/Desktop/Winter 24/FINTECH 3/natgastables.xlsx", sheet = 1)
usethis::use_data(s1, overwrite = T)

s2 <-  readxl::read_excel("C:/Users/conno/OneDrive/Desktop/Winter 24/FINTECH 3/natgastables.xlsx", sheet = 2)
usethis::use_data(s2, overwrite = T)

s3 <-  readxl::read_excel("C:/Users/conno/OneDrive/Desktop/Winter 24/FINTECH 3/natgastables.xlsx", sheet = 3)
usethis::use_data(s3, overwrite = T)

s4 <-  readxl::read_excel("C:/Users/conno/OneDrive/Desktop/Winter 24/FINTECH 3/natgastables.xlsx", sheet = 4)
usethis::use_data(s4, overwrite = T)

s5 <-  readxl::read_excel("C:/Users/conno/OneDrive/Desktop/Winter 24/FINTECH 3/natgastables.xlsx", sheet = 5)
usethis::use_data(s5, overwrite = T)

s7 <-  readxl::read_excel("C:/Users/conno/OneDrive/Desktop/Winter 24/FINTECH 3/natgastables.xlsx", sheet = 6)
usethis::use_data(s7, overwrite = T)

s9 <-  readxl::read_excel("C:/Users/conno/OneDrive/Desktop/Winter 24/FINTECH 3/natgastables.xlsx", sheet = 7)
usethis::use_data(s9, overwrite = T)

s10 <-  readxl::read_excel("C:/Users/conno/OneDrive/Desktop/Winter 24/FINTECH 3/natgastables.xlsx", sheet = 8)
usethis::use_data(s10, overwrite = T)


