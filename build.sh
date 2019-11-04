git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$PATH:$pwd/depot_tools
curl https://github.com/aktau/github-release/releases/download/v0.7.2/darwin-amd64-github-release.tar.bz2 -O github-release.tar.bz2
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
