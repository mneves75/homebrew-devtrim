# typed: false
# frozen_string_literal: true

# Formula for the mneves75/devtrim tap. Binary formula pinned to the attested
# release archive; sha256 must match the published SHA256SUMS.txt exactly.
class Devtrim < Formula
  desc "Developer-machine disk hygiene for macOS: measure, classify, trim - safely"
  homepage "https://mneves75.github.io/devtrim/"
  url "https://github.com/mneves75/devtrim/releases/download/v0.10.9/devtrim-0.10.9-macos-arm64.zip"
  sha256 "b273e1527f4ca872ee58799e1edec8b554bfc8025f33c5ea10778ddce4cc7bcf"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "devtrim"
    generate_completions_from_executable(bin/"devtrim", "completions")
    (man1/"devtrim.1").write Utils.safe_popen_read(bin/"devtrim", "manpage")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devtrim --version")
    assert_match "\"operation\"", shell_output("#{bin}/devtrim history --json")
  end
end
