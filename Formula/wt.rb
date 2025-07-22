class Wt < Formula
  desc "Git worktree CLI helper for task management"
  homepage "https://github.com/rickieplin/wt-cli"
  url "https://github.com/rickieplin/wt-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"

  depends_on "git"

  def install
    bin.install "wt"
  end

  test do
    system "git", "init", "test-repo"
    Dir.chdir("test-repo") do
      system "#{bin}/wt", "-h"
    end
  end
end