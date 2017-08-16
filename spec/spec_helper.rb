require_relative "../lib/jekyll-edit-link"

RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.order = :random
  Kernel.srand config.seed
end

def dest_dir
  File.expand_path("../tmp/dest", File.dirname(__FILE__))
end

def source_dir
  File.expand_path("./fixtures", File.dirname(__FILE__))
end

CONFIG_DEFAULTS = {
  "source"      => source_dir,
  "destination" => dest_dir,
  "plugins"     => ["jekyll-edit-link"],
}.freeze

def make_page(options = {})
  page = Jekyll::Page.new site, CONFIG_DEFAULTS["source"], "", "page.md"
  page.data = options
  page
end

def make_site(options = {})
  config = Jekyll.configuration CONFIG_DEFAULTS.merge(options)
  Jekyll::Site.new(config)
end

def make_context(registers = {}, environments = {})
  context = { :site => make_site, :page => make_page }.merge(registers)
  Liquid::Context.new(environments, {}, context)
end
