class GithubCopilotChatExporter < Formula
  include Language::Python::Virtualenv

  desc "Export GitHub Copilot shared conversations to Markdown and PDF"
  homepage "https://github.com/pandaxbacon/github-copilot-chat-exporter"
  url "https://github.com/pandaxbacon/github-copilot-chat-exporter/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "c44264b16f54ba57b9117f043865ea738d78815db107bbf21ccbd409fb32cdb2"
  license "MIT"

  depends_on "python@3.11"

  def install
    virtualenv_create(libexec, "python@3.11")
    
    # Install the package with all dependencies using setup.py
    system libexec/"bin/pip", "install", "--no-deps", buildpath
    system libexec/"bin/pip", "install", "beautifulsoup4==4.12.3", "playwright==1.48.0", "requests==2.32.3"
    
    # Create wrapper script
    (bin/"copilot-exporter").write_env_script libexec/"bin/copilot-exporter", PATH: "#{libexec}/bin:$PATH"
    
    # Post-install: Playwright browsers
    system libexec/"bin/python", "-m", "playwright", "install", "chromium"
  end

  def caveats
    <<~EOS
      First-time setup: Run login to authenticate with GitHub
        copilot-exporter --mode login --url <SHARE_URL>
      
      Then export conversations:
        copilot-exporter --mode run --url <SHARE_URL> --pdf
    EOS
  end

  test do
    assert_match "Playwright exporter for Copilot share pages", shell_output("#{bin}/copilot-exporter --help")
  end
end
