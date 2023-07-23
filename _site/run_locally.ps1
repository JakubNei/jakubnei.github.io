# https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll

# install required things
bundle install
bundle add webrick


# run
start http://127.0.0.1:4000
bundle exec jekyll serve