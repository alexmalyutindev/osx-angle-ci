git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$PATH:$PWD/depot_tools
export FORCE_MAC_SDK_MIN=10.10
git clone -n https://chromium.googlesource.com/angle/angle
# Try older commit Could be nearly the last working Version for 32 bit MacOs <= 10.14
git checkout ba65c156cf76e73ddbb405a26f299cf079af0f92
cd angle
python scripts/bootstrap.py
gclient sync
git checkout master
gn gen out/Release --args='target_cpu="x86" is_debug=false'
autoninja -C out/Release
cd ..
mkdir ./artifacts
cp angle/out/Release/*.dylib ./artifacts/
cp angle/out/Release/*.a ./artifacts/
