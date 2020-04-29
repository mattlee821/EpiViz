FROM rocker/r-ver:3.6.2

RUN apt-get update && apt-get install -y \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    xtail \
    wget \
    curl \
    libssl-dev


# Download and install shiny server
RUN wget --no-verbose https://download3.rstudio.org/ubuntu-14.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    . /etc/environment && \
    R -e "install.packages(c('shiny', 'rmarkdown'), repos='$MRAN')" && \
    cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/ && \
    chown shiny:shiny /var/lib/shiny-server


RUN R -e "install.packages(c('shiny', 'shinydashboard','BiocManager','shinydashboard','shinyLP','shinythemes','shinycssloaders','plotly','openssl','circlize','fs','devtools','wesanderson'), repos='http://cran.rstudio.com/')"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
   libfftw3-dev \
   gcc && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
 
RUN Rscript  -e 'BiocManager::install("ComplexHeatmap")'

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh
COPY /app /srv/shiny-server/


CMD ["/usr/bin/shiny-server.sh"]


###Things I tried for ref!
#CMD ["exec shiny-server 2>&1"]
#CMD ["/usr/bin/shiny-server.sh & R -e `shiny::runApp(appDir='/srv/shiny-server',host='0.0.0.0',port=7724)` && fg "]
#CMD ["R -e `setwd('/srv/shiny-server');shiny::runApp(host='0.0.0.0',port=7724)`"]
#CMD ["cd /srv/shiny-server"]
#RUN R -e "shiny::runApp(appDir='/srv/shiny-server',host='0.0.0.0',port=7724)"
#RUN R -e "setwd('/srv/shiny-server');shiny::runApp(host='0.0.0.0',port=7724)" 
#CMD ["/srv/shinyserver/R -e "shiny::runApp(host='0.0.0.0',port=7724)"]