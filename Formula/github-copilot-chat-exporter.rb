class GithubCopilotChatExporter < Formula
  include Language::Python::Virtualenv

  desc "Export GitHub Copilot shared conversations to Markdown and PDF"
  homepage "https://github.com/pandaxbacon/github-copilot-chat-exporter"
  url "https://github.com/pandaxbacon/github-copilot-chat-exporter/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "c44264b16f54ba57b9117f043865ea738d78815db107bbf21ccbd409fb32cdb2"
  license "MIT"

  depends_on "python@3.11"

  def install
    # Use standard Python formula pattern
    venv = virtualenv_create(libexec, Formula["python@3.11"].bin/"python3.11")
    venv.pip_install_and_link buildpath
    
    # Install Playwright browsers after package is installed
    system libexec/"bin/playwright", "install", "chromium" if build.head?
  end

  def post_install
    # Install Playwright browsers in post-install
    system "#{libexec}/bin/playwright", "install", "chromium", "--with-deps"
  rescue StandardError
    opoo "Playwright browser installation failed. Run manually:"
    opoo "  #{libexec}/bin/playwright install chromium"
  end

  def caveats
    <<~EOS
      First-time setup: Authenticate with GitHub
        copilot-exporter --mode login --url <SHARE_URL>
      
      Export conversations:
        copilot-exporter --mode run --url <SHARE_URL> --pdf
      
      If Playwright browsers didn't install:
        #{libexec}/bin/playwright install chromium
    EOS
  end

  test do
    assert_match "Playwright exporter", shell_output("#{bin}/copilot-exporter --help")
  end
end
