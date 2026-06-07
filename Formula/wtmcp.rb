class Wtmcp < Formula
  desc "MCP server with plugin-based integrations for developer tools"
  homepage "https://github.com/LeGambiArt/wtmcp"
  license "GPL-3.0-only"
  head "https://github.com/LeGambiArt/wtmcp.git", branch: "main"

  depends_on "go" => :build
  depends_on "python@3"

  def install
    version_str = if build.head?
      Utils.git_short_head
    else
      version.to_s
    end

    build_date = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")

    ldflags = %W[
      -s -w
      -X main.Version=#{version_str}
      -X main.BuildDate=#{build_date}
    ]
    goflags = %w[-trimpath -buildmode=pie]

    system "go", "build", *goflags, *std_go_args(ldflags:), "./cmd/wtmcp"
    system "go", "build", *goflags, *std_go_args(ldflags:, output: bin/"wtmcpctl"), "./cmd/wtmcpctl"

    go_plugins = %w[bugzilla gitlab google-calendar google-docs google-drive google-gmail]
    go_plugins.each do |plugin|
      system "go", "build", *goflags, "-ldflags", ldflags.join(" "),
             "-o", "plugins/#{plugin}/handler", "./plugins/#{plugin}"
    end

    Dir.glob("plugins/*/plugin.yaml").each do |yaml_path|
      plugin_dir = Pathname.new(File.dirname(yaml_path))
      plugin_name = File.basename(plugin_dir)
      next if plugin_name.start_with?("_")

      target = share/"wtmcp/plugins"/plugin_name
      target.install Dir[plugin_dir/"plugin.yaml"]
      target.install Dir[plugin_dir/"context.md"]
      target.install Dir[plugin_dir/"handler"] if File.exist?(plugin_dir/"handler")
      Dir.glob(File.join(plugin_dir, "*.py")).each { |f| target.install f }
    end
  end

  def caveats
    <<~EOS
      Plugins are installed to:
        #{share}/wtmcp/plugins/

      Configure credentials in:
        ~/.config/wtmcp/env.d/
    EOS
  end

  test do
    assert_match(/\d/, shell_output("#{bin}/wtmcp --version"))
    assert_match(/\d/, shell_output("#{bin}/wtmcpctl --version"))
  end
end
