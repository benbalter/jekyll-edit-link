require "jekyll"

module JekyllEditLink
  autoload :Tag, "jekyll-edit-link/tag"
  autoload :VERSION, "jekyll-edit-link/version"
end

Liquid::Template.register_tag("edit_link", JekyllEditLink::Tag)
