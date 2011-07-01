# Write in this file customization code that will get executed after all the
# soures have beenloaded.

# MQ does not build with boost version greater 1.42
if package_selected?('rtt')   
    package('rtt').define "PLUGINS_ENABLE_SCRIPTING", "OFF"
    package('rtt').define "ENABLE_MQ", "ON"
end

setup_package 'external/opencv' do |pkg|
    pkg.define "BUILD_TESTS", "OFF"
    pkg.define "WITH_FFMPEG", "OFF"
    pkg.define "WITH_V4L", "OFF"
    pkg.define "BUILD_EXAMPLES", "OFF"
end

Autobuild::Orogen.always_regenerate = false
