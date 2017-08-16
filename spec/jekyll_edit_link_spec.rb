RSpec.describe JekyllEditLink do
  let(:repository_url) { "https://github.com/benbalter/jekyll-edit-link" }
  let(:branch) { "master" }
  let(:path) { "/" }
  let(:source) { { "branch" => branch, "path" => path } }
  let(:github) { { "repository_url" => repository_url, "source" => source } }
  let(:config)    { { "github" => github } }
  let(:page)      { make_page }
  let(:site)      { make_site(config) }
  let(:context)   { make_context(:page => page, :site => site) }
  let(:tag)       { "edit_link" }
  let(:text)      { "" }
  let(:output)    { Liquid::Template.parse("{% #{tag} #{text} %}").render!(context, {}) }

  before do
    Jekyll.logger.log_level = :error
  end

  it "retruns the version" do
    expect(described_class::VERSION).to match(%r!\d+\.\d+\.\d+!)
  end

  context "when empty" do
    it "renders the URL" do
      expect(output).to match("#{repository_url}/edit/master/page.md")
    end
  end

  context "when passed a string" do
    let(:text) { '"Improve this page"' }

    it "renders the link" do
      expected = "<a href=\"#{repository_url}/edit/master/page.md\">Improve this page</a>"
      expect(output).to match(expected)
    end
  end
end
