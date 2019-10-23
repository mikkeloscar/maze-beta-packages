#!/usr/bin/env ruby

require 'yaml'

$UGNAME="builder"
$REPO="https://beta.maze-ci.org/mikkeloscar/maze"

# setup build dir
Dir.mkdir("build", 0700)
system("sudo", "chown", "1000:1000", "-R", "build")

packages = YAML.load(File.read("packages.yml"))

packages["aur"].each { |package|
  puts "=== #{package["name"]} ==="
  args = [
    "run",
    "--net=host",
    "--rm", "-it",
    "-v", "#{Dir.getwd}/build:/build",
    "-w", "/build",
    "--user", "#{$UGNAME}:#{$UGNAME}",
    "mikkeloscar/maze-build-travis:latest",
    "--repo", $REPO,
    "--origin", "aur",
    "--package", package["name"],
    "--upload",
    "--ping",
    "--token", ENV["TOKEN"],
  ]

  if package.key?("signing_keys")
    package["signing_keys"].each { |key|
      args.push("--signing-key")
      args.push(key)
    }
  end

  system("docker", *args)

  # clean build dir
  system("sudo", "rm", "-rf", "build/*")
}
