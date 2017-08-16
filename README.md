# Jekyll Edit Link

A Jekyll tag that generates links to edit the current page on GitHub

[![Build Status](https://travis-ci.org/benbalter/jekyll-edit-link.svg?branch=master)](https://travis-ci.org/benbalter/jekyll-edit-link)

## Installation

1. Add the following to your site's Gemfile `gem 'jekyll-edit-link'`
2. Add the `jekyll-edit-link` to the list of plugins in your site's config

## Usage

### To generate a link

```liquid
<p>This site is open source. {% edit_link "Improve this page" %}</p>
```

Produces:

```html
<p>This site is open source. <a href="https://github.com/benbalter/jekyll-edit-link/edit/master/README.md">Improve this page</a></p>
```

### To generate a path

If you'd prefer to build your own link, simply don't pass link text

```liquid
<p>This site is open source. <a href="{% edit_link %}">Improve this page</a></p>
```

Produces:


```html
<p>This site is open source. <a href="https://github.com/benbalter/jekyll-edit-link/edit/master/README.md">Improve this page</a></p>
```
