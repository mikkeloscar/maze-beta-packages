#!/bin/bash

UGNAME="builder"
REPO="https://beta.maze-ci.org/mikkeloscar/maze"

# if [ "$TRAVIS_EVENT_TYPE" == "cron" ]; then
    aur_pkgs=$(ruby -ryaml -e 'puts ARGV[1..-1].inject(YAML.load(File.read(ARGV[0]))) {|acc, key| acc[key] }' packages.yml aur)

    ls -la
    pwd
    mkdir -p build
    sudo chown 1000:1000 -R build 
    ls -la
    pwd

    # for pkg in $aur_pkgs; do
    #     docker run --net=host --rm -it -v "$(pwd)/build:/build" -w "/build" \
    #         --user $UGNAME:$UGNAME mikkeloscar/maze-build-travis:latest \
    #         --repo $REPO \
    #         --origin aur \
    #         --package $pkg \
    #         --upload
    # done
# fi
