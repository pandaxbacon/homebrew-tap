class CopilotExporter < Formula
  include Language::Python::Virtualenv

  desc "Export GitHub Copilot shared conversations to Markdown and PDF"
  homepage "https://github.com/pandaxbacon/github-copilot-chat-exporter"
  url "https://github.com/pandaxbacon/github-copilot-chat-exporter/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "c44264b16f54ba57b9117f043865ea738d78815db107bbf21ccbd409fb32cdb2"
  license "MIT"

  depends_on "python@3.11"

  resource "beautifulsoup4" do
    url "https://files.pythonhosted.org/packages/b3/ca/824b1195773ce6166d388573fc106ce56d4a805bd7427b624e063596ec58/beautifulsoup4-4.12.3.tar.gz"
    sha256 "74e3d1928edc070d21748185c46e3fb33490f22f52a3addee9aee0f4f7781051"
  end

  resource "playwright" do
    url "https://files.pythonhosted.org/packages/0a/7f/44b87646e19077e6e3f33c6c7c97f352a4f5f76c8c5dda9eb359b86f6ef7/playwright-1.48.0.tar.gz"
    sha256 "8e89d2024a002619a5675fbc7b2c670ed4fa217a54e0e93d2bf63ab3d3ea9363"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/63/70/2bf7780ad2d390a8d301ad0b550f1581eadbd9a20f896afe06353c2a2913/requests-2.32.3.tar.gz"
    sha256 "55365417734eb18255590a9ff9eb97e9e1da868d4ccd6402399eaf68af20a760"
  end

  def install
    virtualenv_install_with_resources
    
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
    system bin/"copilot-exporter", "--help"
  end
end

