# Write in this file customization code that will get executed after all the
# soures have beenloaded.

# MQ does not build with boost version greater 1.42
if package_selected?('rtt')   
    package('rtt').define "PLUGINS_ENABLE_SCRIPTING", "OFF"
    package('rtt').define "ENABLE_MQ", "OFF"
end

Autobuild::Orogen.extended_states = true

PRODUCTION_PACKAGES = [
    'base',
    'drivers/canbus',  'drivers/orogen/canbus',
    'drivers/hbridge', 'drivers/orogen/hbridge',
    'drivers/hokuyo',  'drivers/orogen/hokuyo',
    'drivers/dsp3000',  'drivers/orogen/dsp3000',
    'drivers/iodrivers_base',
    'typelib',
    'orocos/base',
    'orocos/rtt',
    'orocos/logger',
    'avalon/stateEstimator', 
    'avalon/orogen/stateEstimator', 
    'orocos/logger',
    'avalon/orogen/ekfSLAM',
    'avalon/ekf_slam'
    ]

RELWITHDEBUG_PACKAGES = []

Autobuild::Package.each do |name, pkg|
    if PRODUCTION_PACKAGES.include?(pkg.name)
        pkg.define "CMAKE_BUILD_TYPE", "Release"
    elsif RELWITHDEBUG_PACKAGES.include?(pkg.name)
        pkg.define "CMAKE_BUILD_TYPE", "RelWithDebInfo"
    elsif pkg.kind_of?(Autobuild::CMake)
        pkg.define "CMAKE_BUILD_TYPE", "Debug"
    end
end

