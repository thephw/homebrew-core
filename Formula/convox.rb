class Convox < Formula
  desc "Command-line interface for the Rack PaaS on AWS"
  homepage "https://convox.com/"
  url "https://github.com/convox/rack/archive/20180412033556.tar.gz"
  sha256 "df92b9c6a49ee17c6c111649f8a98c996e7118435c37fb36d4c6877c7f71068a"

  bottle do
    cellar :any_skip_relocation
    sha256 "52433b904063396e1c424d58a59ff4944c00ba9271d3184a7bd192d58707028e" => :high_sierra
    sha256 "dafa959c341b2db48c827b4d05cac9efca821142eec1861eeed24234a363b7d5" => :sierra
    sha256 "db2579f8bdc082e0fce2a67316a2e08833e9153c5a9c99388aa3d6301c23adf9" => :el_capitan
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/convox/rack").install Dir["*"]
    system "go", "build", "-ldflags=-X main.Version=#{version}",
           "-o", bin/"convox", "-v", "github.com/convox/rack/cmd/convox"
  end

  test do
    system bin/"convox"
  end
end
