FROM httpd:2.4

## Step 1:
# Create a working directory
WORKDIR /tmp

## Step 2:
# Copy source code to working directory
ADD ./travel-blog-site.tar.gz /usr/local/apache2/htdocs/

## Step 3:
# Expose port 80
EXPOSE 80

