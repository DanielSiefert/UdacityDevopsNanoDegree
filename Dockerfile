FROM httpd

## Step 1:
# Create a working directory
WORKDIR /tmp

## Step 2:
# Copy source code to working directory
COPY ./travel-blog-site.tar.gz /tmp/travel-blog-site.tar.gz

## Step 3:
#Extract sourcecode to Apache httpd default directory
# hadolint ignore=DL3013
RUN tar -zxf /tmp/travel-blog-site.tar.gz -C /usr/local/apache2/htdocs/
RUN rm /tmp/travel-blog-site.tar.gz

## Step 4:
# Expose port 80
EXPOSE 80

