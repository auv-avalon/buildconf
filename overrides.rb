# Write in this file customization code that will get executed after all the
# soures have beenloaded.

# MQ does not build with boost version greater 1.42
if package_selected?('rtt')   
    package('rtt').define "PLUGINS_ENABLE_SCRIPTING", "OFF"
    package('rtt').define "ENABLE_MQ", "ON"
end


setup_package 'gui/rock_widget_collection' do |pkg|
    pkg.define "USE_VTK", "ON"
end

#setup_package 'external/opencv' do |pkg|
#    pkg.define "BUILD_TESTS", "OFF"
#    pkg.define "WITH_FFMPEG", "OFF"
#    pkg.define "WITH_V4L", "OFF"
#    pkg.define "BUILD_EXAMPLES", "OFF"
#end

setup_package('slam/envire') do |pkg|
    pkg.parallel_build_level = 1
end

require "socket"
if Socket.gethostname != "mgoldhoorn" 
    setup_package 'simulation/mars/graphics' do |pkg|
        STDOUT.puts "####  Disableing Depth image support on mars  ####"
        pkg.define "DEPTH_IMAGES", "OFF"
    end
end

Autobuild::Orogen.always_regenerate = true 


if Socket.gethostname == "avalon-rear" or Socket.gethostname == "avalon"
        STDOUT.puts "####  Not building GUI Based packes on Avalon  ####"
        ignore "gui/vizkit"
        ignore "gui/rock_widget_collection"
        ignore "simulation/.*"
        ignore "avalon/orogen/avalon_simulation_deployment"
        ignore "avalon/orogen/laserToPosition"
        ignore "avalon/gui/sonarbeamviz"
        ignore "avalon/gui/movement"
        ignore "avalon/gui/rangeScanner"
        ignore "avalon/gui/sonar"
        ignore "avalon/orogen/sonar_vizkit"
        ignore "avalon/orogen/movementGUI"
        ignore "avalon/orogen/sonarGUI"
        ignore "avalon/orogen/movement_experiment"
        ignore ".*structured_light"
end

    
#checking out the new version of yaml for avalon
setup_package 'external/yaml-cpp' do |pkg|
    pkg.define("BUILD_SHARED_LIBS","ON")
        update_archive(pkg, "http://yaml-cpp.googlecode.com/files/yaml-cpp-0.3.0.tar.gz", "0.3.0") do
        File.readlines(File.join(pkg.srcdir,"CMakeLists.txt")).grep(/YAML_CPP_VERSION_MINOR "3"/) == []
    end
end
