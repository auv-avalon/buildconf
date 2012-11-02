# Write in this file customization code that will get executed after all the
# soures have beenloaded.

# MQ does not build with boost version greater 1.42
if package_selected?('rtt')   
    package('rtt').define "PLUGINS_ENABLE_SCRIPTING", "OFF"
    package('rtt').define "ENABLE_MQ", "ON"
end

Autobuild::Orogen.always_regenerate = true 


require "socket"
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

