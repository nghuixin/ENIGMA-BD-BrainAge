# Start with R version 4.1.0
FROM rocker/r-ver:4.3.1

# Install some linux libraries that R packages need
RUN apt-get update && apt-get install -y libcurl4-openssl-dev libssl-dev libxml2-dev

# Use renv version 0.15.2
#ENV RENV_VERSION 0.15.2

# Install renv
RUN R -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"
#RUN Rscript -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

# Create a directory named after our project directory
WORKDIR /project/ENIGMAbrainAGE

# Copy the lockfile over to the Docker image
COPY renv.lock renv.lock

# Install all R packages specified in renv.lock
RUN Rscript -e 'renv::restore()'
 