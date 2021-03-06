RSpec.describe JekyllEditLink::Tag do
  let(:repository_url) { "https://github.com/benbalter/jekyll-edit-link" }
  let(:branch) { "master" }
  let(:path) { "/" }
  let(:source) { { "branch" => branch, "path" => path } }
  let(:github) { { "repository_url" => repository_url, "source" => source } }
  let(:config)    { { "github" => github } }
  let(:page)      { make_page }
  let(:site)      { make_site(config) }
  let(:render_context) { make_context(:page => page, :site => site) }
  let(:tag_name)  { "edit_link" }
  let(:markup)    { "" }
  let(:tokenizer) { Liquid::Tokenizer.new("") }
  let(:parse_context) { Liquid::ParseContext.new }
  let(:uri) { subject.uri.to_s }
  let(:rendered) { subject.render(render_context) }

  subject do
    tag = described_class.parse(tag_name, markup, tokenizer, parse_context)
    tag.instance_variable_set("@context", render_context)
    tag
  end

  before do
    Jekyll.logger.log_level = :error
  end

  it "knows the page" do
    expect(subject.page).to be_a(Jekyll::Page)
  end

  it "knows the site" do
    expect(subject.site).to be_a(Jekyll::Drops::SiteDrop)
  end

  it "knows there's no link text" do
    expect(subject.link_text).to be_nil
  end

  context "building the URL" do
    it "builds the URL" do
      expect(uri).to eql("#{repository_url}/edit/master/page.md")
    end

    context "a docs/ site" do
      let(:path) { "docs/" }

      it "builds the URL" do
        expect(uri).to eql("#{repository_url}/edit/master/docs/page.md")
      end
    end

    context "a gh-pages site" do
      let(:branch) { "gh-pages" }

      it "builds the URL" do
        expect(uri).to eql("#{repository_url}/edit/gh-pages/page.md")
      end
    end
  end

  context "with no site.github" do
    let(:github) {}

    it "returns an empty string" do
      expect(uri).to eql("")
    end
  end

  context "with site.github as a string" do
    let(:github) { "@benbalter" }

    it "returns an empty string" do
      expect(uri).to eql("")
    end
  end

  context "with repository_url as a hash" do
    let(:repository_url) { { "foo" => "bar" } }

    it "doesn't blow up" do
      expect { uri }.to_not raise_error
    end
  end

  context "normalization" do
    it "ensures a string is not just a slash" do
      expect(subject.ensure_not_just_a_slash("/")).to eql("")
    end

    it "adds a trailing slash" do
      expect(subject.ensure_trailing_slash("foo")).to eql("foo/")
    end

    it "doesn't double add a trailing slash" do
      expect(subject.ensure_trailing_slash("foo/")).to eql("foo/")
    end

    it "strips a leading slash" do
      expect(subject.remove_leading_slash("/foo/")).to eql("foo/")
    end
  end

  context "parts" do
    it "builds the parts" do
      expected = [github["repository_url"], "edit/", "master", "/", "page.md"]
      expect(subject.parts).to eql(expected)
    end

    it "normalizes parts" do
      expected = [github["repository_url"] + "/", "edit/", "master/", "", "page.md"]
      expect(subject.parts_normalized).to eql(expected)
    end
  end

  context "when passed text with single quotes" do
    let(:markup) { " 'Improve this page' " }

    it "pulls the link text" do
      expect(subject.link_text).to eql("Improve this page")
    end
  end

  context "when passed text with double quotes" do
    let(:markup) { ' "Improve this page" ' }

    it "pulls the link text" do
      expect(subject.link_text).to eql("Improve this page")
    end
  end

  context "rendering" do
    it "returns a URL" do
      expect(rendered).to eql("#{repository_url}/edit/master/page.md")
    end

    context "when passed markup" do
      let(:markup) { '"Improve this page"' }

      it "returns a link" do
        expected = "<a href=\"#{repository_url}/edit/master/page.md\">"
        expected << "Improve this page</a>"
        expect(rendered).to match(expected)
      end
    end
  end
end
