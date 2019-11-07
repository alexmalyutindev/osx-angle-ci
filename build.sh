git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$PATH:$PWD/depot_tools
git clone -n https://chromium.googlesource.com/angle/angle
cd angle
# Try older commit could be nearly the last working Version for 32 bit MacOs <= 10.14 without patches
export BUILD_COMMIT=${BUILD_COMMIT:-076fae01016528aa58a8af7ea817a922d297cc53}
git checkout ${BUILD_COMMIT}
python scripts/bootstrap.py
gclient sync
git checkout ${BUILD_COMMIT}
gn gen out/Release --args='target_cpu="x86" is_debug=false mac_sdk_min="10.10"'
autoninja -C out/Release
cd ..
mkdir ./artifacts
cp angle/out/Release/*.dylib ./artifacts/ > /dev/null || :
cp angle/out/Release/*.a ./artifacts/ > /dev/null || :