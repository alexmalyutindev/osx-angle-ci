git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git --depth=1
export PATH=$PATH:$PWD/depot_tools
git clone https://github.com/google/angle.git --depth=1
cd angle
python3 scripts/bootstrap.py
gclient sync --shallow --no-history -D -R
gn gen out/Release --args='target_cpu="arm64" is_debug=false mac_sdk_min="10.10" angle_enable_metal=true angle_enable_glsl=true angle_enable_swiftshader=false angle_enable_vulkan=false'
autoninja -C out/Release libEGL libGLESv2
cd ..
mkdir ./artifacts
cp angle/out/Release/*.dylib ./artifacts/ > /dev/null || :