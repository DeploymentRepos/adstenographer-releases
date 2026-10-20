# Written for each release by the agentic developer toolkit's release CLI
# (release_macos_app.py), from release/cask.rb.template in the Stenographer repo.
# Do not edit by hand.
cask "stenographer" do
  version "1.4.0"
  sha256 "a6420686add6c642b237d2aeccd7c3ff8a66ecf364a6ab78d1e98940edd11826"

  url "https://github.com/DeploymentRepos/adstenographer-releases/releases/download/v#{version}/Stenographer-#{version}.pkg"
  name "Stenographer"
  desc "Records Claude Code session activity"
  homepage "https://agenticdeveloperstenographer.com/"

  livecheck do
    url "https://agenticdeveloperstenographer.com/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  pkg "Stenographer-#{version}.pkg"

  uninstall launchctl: [
              "com.agentic-cookbook.stenographer",
              "com.agentic-cookbook.stenographer.menubar",
              "com.agenticdevelopmentstudio.stenographer",
            ],
            quit:      "com.agenticdevelopmentstudio.stenographer",
            script:    {
              executable: "/Applications/Stenographer.app/Contents/MacOS/stenographerd",
              args:       ["--uninstall-hooks"],
            },
            pkgutil:   "com.agenticdevelopmentstudio.stenographer",
            delete:    [
              "~/.claude/stenographer.sock",
              "~/Library/LaunchAgents/com.agentic-cookbook.stenographer.menubar.plist",
              "~/Library/LaunchAgents/com.agentic-cookbook.stenographer.plist",
              "~/Library/LaunchAgents/com.agenticdevelopmentstudio.stenographer.plist",
            ]

  zap trash: [
    "~/.claude/stenographer-capture.py",
    "~/.claude/stenographer-events",
    "~/Library/Logs/com.agentic-cookbook.stenographer",
    "~/Library/Logs/com.agenticdevelopmentstudio.stenographer",
  ]

  caveats <<~EOS
    The `steno` command at /usr/local/bin/steno is a link the Stenographer app
    manages: turn it on or off in Manage Stenographer Tools.
  EOS
end
