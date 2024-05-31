# frozen_string_literal: true

require 'mustache'
require 'front_matter_parser'
require 'time'

FRONTMATTER_SCHEMA = %w[
  address
  firstname
  lastname
  byline
  font_family
  title
  page_size
  email
].freeze

METADATA_FILENAME = 'metadata.yaml'

filename = ARGV[0]
metadata_filename = ARGV[1] ||= METADATA_FILENAME

default_context = {
  'page_size' => 'A4',
  'font_family' => '"Times New Roman", Times, serif'
}

common_context = if File.exist?(metadata_filename)
                   YAML.load_file(metadata_filename, permitted_classes: [Time])
                 else
                   {}
                 end

safe_loader = FrontMatterParser::Loader::Yaml.new(allowlist_classes: [Time])
parsed = FrontMatterParser::Parser.parse_file(filename, loader: safe_loader)
context = default_context
          .merge(common_context)
          .merge(parsed.front_matter)

missing_keys = FRONTMATTER_SCHEMA - context.keys
raise "Missing keys in frontmatter: #{missing_keys}" unless missing_keys.empty?

template = File.read("#{Dir.pwd}/templates/manuscript.css.mustache")

css = Mustache.render(template, context)
File.write("#{Dir.pwd}/rendered/manuscript.css", css)
