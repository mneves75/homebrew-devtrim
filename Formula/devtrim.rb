# typed: false
# frozen_string_literal: true

# Formula for the mneves75/devtrim tap. Binary formula pinned to the attested
# release archive; sha256 must match the published SHA256SUMS.txt exactly.
class Devtrim < Formula
  desc "Developer-machine disk hygiene for macOS: measure, classify, trim - safely"
  homepage "https://mneves75.github.io/devtrim/"
  url "https://github.com/mneves75/devtrim/releases/download/v0.7.0/devtrim-0.7.0-macos-arm64.zip"
  sha256 "3a93d146d51f40bfec7ec54c29369472d6706d8ff0b5caa40cab24425917d802"
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
