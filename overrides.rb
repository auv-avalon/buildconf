# Write in this file customization code that will get executed after all the
# soures have beenloaded.

# MQ does not build with boost version greater 1.42
if package_selected?('rtt')   
    package('rtt').define "PLUGINS_ENABLE_SCRIPTING", "OFF"
    package('rtt').define "ENABLE_MQ", "ON"
end

#Test setup for https://rock.opendfki.de/ticket/384
Autoproj.post_import do |pkg|
    if pkg.kind_of?(Autobuild::CMake)
        pkg.define "CMAKE_EXPORT_COMPILE_COMMANDS", "ON"
    end
end

#Not really currently supported by Alex 11.07.2013
#setup_package 'gui/rock_widget_collection' do |pkg|
#    pkg.define "USE_VTK", "ON"
#end

#setup_package 'external/opencv' do |pkg|
#    pkg.define "BUILD_TESTS", "OFF"
#    pkg.define "WITH_FFMPEG", "OFF"
#    pkg.define "WITH_V4L", "OFF"
#    pkg.define "BUILD_EXAMPLES", "OFF"
#end

setup_package('slam/envire') do |pkg|
    pkg.parallel_build_level = 1
end


#if Autoproj.user_config('ROCK_FLAVOR') == 'next'
#    setup_package('orogen') do |pkg|
#        pkg.importer = Autobuild::Git.new(pkg.importer.repository,pkg.importer.branch,:commit => "2442b57d8e5da5f3ecaca7b2e291308ebe7f88a1")
#    end
#end

#Autobuild::Orogen.always_regenerate = true 


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
#setup_package 'external/yaml-cpp' do |pkg|
#    pkg.define("BUILD_SHARED_LIBS","ON")
#        update_archive(pkg, "http://yaml-cpp.googlecode.com/files/yaml-cpp-0.3.0.tar.gz", "0.3.0") do
#        File.readlines(File.join(pkg.srcdir,"CMakeLists.txt")).grep(/YAML_CPP_VERSION_MINOR "3"/) == []
#    end
#end
#remove_from_default 'external/sisl'

if Autoproj::Metapackage.method_defined?(:weak_dependencies?)
    metapackage('rock').weak_dependencies = true
    metapackage('rock.toolchain').weak_dependencies = true
    metapackage('rock.base').weak_dependencies = true
end


#if not Socket.gethostname.include?("build")
#    File.open(File.join(Autoproj.root_dir,'install','bin', 'ruby'), "r+") do |io|
#        s = io.read
#        if not s.include?("-rpy")
#            s.sub!("\"$@\""," -rpry \"$@\"")
#            io.seek(0)
#            io.write(s)
#        end
#        package('avalon/orogen/avalon_base').depends_on 'pry' 
#    end
#end


#cmake_package 'external/sisl' do |pkg|
#    pkg.define "BUILD_SHARED_LIBS","ON"
#    update_archive(pkg, "http://www.sintef.no/upload/IKT/9011/geometri/sisl/sisl-4.5.0.tar.gz", "4.5.0") do
#            !File.exists?(File.join(pkg.srcdir,"CMakeLists.txt"))
#    end
#end
