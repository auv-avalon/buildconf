# Write in this file customization code that will get executed after all the
# soures have beenloaded.

# MQ does not build with boost version greater 1.42
if package_selected?('rtt')   
    package('rtt').define "ENABLE_MQ", "OFF"
end
