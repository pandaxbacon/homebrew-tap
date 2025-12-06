class GithubCopilotChatExporter < Formula
  include Language::Python::Virtualenv

  desc "Export GitHub Copilot shared conversations to Markdown and PDF"
  homepage "https://github.com/pandaxbacon/github-copilot-chat-exporter"
  url "https://github.com/pandaxbacon/github-copilot-chat-exporter/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "c44264b16f54ba57b9117f043865ea738d78815db107bbf21ccbd409fb32cdb2"
  license "MIT"

  depends_on "python@3.11"

  def install
    # Install the package and let setup.py handle dependencies
    virtualenv_install_with_resources
  end

  def post_install
    # Install Playwright browsers after package installation
    system libexec/"bin/playwright", "install", "chromium"
  end

  def caveats
    <<~EOS
      Playwright browsers are being installed...
      This may take a few minutes on first install.
      
      First-time setup: Authenticate with GitHub
        copilot-exporter --mode login --url <SHARE_URL>
      
      Export conversations:
        copilot-exporter --mode run --url <SHARE_URL> --pdf
    EOS
  end

  test do
    assert_match "Playwright exporter", shell_output("#{bin}/copilot-exporter --help")
  end
end
