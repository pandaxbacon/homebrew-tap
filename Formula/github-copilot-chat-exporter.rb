class GithubCopilotChatExporter < Formula
  desc "Export GitHub Copilot shared conversations to Markdown with file attachment capture"
  homepage "https://github.com/pandaxbacon/github-copilot-chat-exporter"
  url "https://github.com/pandaxbacon/github-copilot-chat-exporter/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "5b786eb40498eca1e874af1d42f20e6fe53f9f2210f2bf5d4745db627461bfcd"
  license "MIT"

  depends_on "python@3.11"

  def install
    # Install files to libexec
    libexec.install Dir["*"]
    
    # Create wrapper script
    (bin/"copilot-exporter").write <<~EOS
      #!/bin/bash
      SCRIPT_DIR="#{libexec}"
      
      # Check if venv exists, create if not
      if [ ! -d "$SCRIPT_DIR/.venv" ]; then
        echo "First-time setup: Creating virtual environment..."
        python3.11 -m venv "$SCRIPT_DIR/.venv"
        "$SCRIPT_DIR/.venv/bin/pip" install -q -r "$SCRIPT_DIR/requirements.txt"
        "$SCRIPT_DIR/.venv/bin/playwright" install chromium >/dev/null 2>&1
      fi
      
      # Run the script
      exec "$SCRIPT_DIR/.venv/bin/python" "$SCRIPT_DIR/scraper_playwright.py" "$@"
    EOS
    
    chmod 0755, bin/"copilot-exporter"
  end

  def caveats
    <<~EOS
      First-time setup: Authenticate with GitHub
        copilot-exporter --mode login --url <SHARE_URL>
      
      Export conversations:
        copilot-exporter --mode run --url <SHARE_URL>
      
      With file attachments (CSV, JSON, TXT, YAML, code files):
        copilot-exporter --mode run --url <SHARE_URL> --with-assets
      
      Note: First run will set up dependencies automatically (may take 1-2 minutes)
    EOS
  end

  test do
    assert_match "usage", shell_output("#{bin}/copilot-exporter --help 2>&1", 2)
  end
end
