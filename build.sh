git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$PATH:$PWD/depot_tools
export FORCE_MAC_SDK_MIN=10.10
curl -L https://github.com/aktau/github-release/releases/download/v0.7.2/darwin-amd64-github-release.tar.bz2 --output github-release.tar.bz2
tar -xf github-release.tar.bz2
git clone https://chromium.googlesource.com/angle/angle
cd angle
python scripts/bootstrap.py
gclient sync
git checkout master
gn gen out/Release --args='target_cpu="x86" is_debug=false'
autoninja -C out/Release
cd ..
cp angle/out/Release/*.dylib ./artifacts/
