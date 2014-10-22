# Write in this file customization code that will get executed before 
# autoproj is loaded.

# Set the path to 'make'
# Autobuild.commands['make'] = '/path/to/ccmake'

# Set the parallel build level (defaults to the number of CPUs)
# Autobuild.parallel_build_level = 10

# Uncomment to initialize the environment variables to default values. This is
# useful to ensure that the build is completely self-contained, but leads to
# miss external dependencies installed in non-standard locations.
#
# set_initial_env
#
# Additionally, you can set up your own custom environment with calls to env_add
# and env_set:
#
env_add 'PATH', "/usr/lib/ccache/"
# env_set 'CMAKE_PREFIX_PATH', "/opt/boost;/opt/xerces"
# env_set 'CMAKE_INSTALL_PATH', "/opt/orocos"
#
# NOTE: Variables set like this are exported in the generated 'env.sh' script.
#

#
# Orocos Specific ignore rules
#
# Ignore log files generated from the orocos/orogen components
ignore(/\.log$/, /\.ior$/, /\.idx$/)
# Ignore all text files except CMakeLists.txt
ignore(/(^|\/)(?!CMakeLists)[^\/]+\.txt$/)
# We don't care about the manifest being changed, as autoproj *will* take
# dependency changes into account
ignore(/manifest\.xml$/)
# Ignore vim swap files
ignore(/\.sw?$/)
# Ignore the numerous backup files
ignore(/~$/)

require "autoproj/gitorious"

#Setting default flavor
#if !Autoproj.has_config_key?('ROCK_FLAVOR')
#       STDOUT.puts "### Setting Default rock-flavor for Avalon to next, if you are sure abort bootstrap cancel after this step and edit config.yml by hand ###" #was added to keep the botstrap as simple as possible for the students
#       Autoproj.change_option('ROCK_FLAVOR', 'next', true)
#end 

Autoproj.gitorious_server_configuration('GITORIOUS', 'gitorious.org')
Autoproj.gitorious_server_configuration('SPACEGIT', 'git.hb.dfki.de',:fallback_to_http => false)
Autoproj.gitorious_server_configuration('GITHUB', 'github.com', :http_url => 'https://github.com')

#Autoproj.change_option('GITORIOUS_ROOT', 'git://192.168.128.10')
#Autoproj.change_option('GITORIOUS_PUSH_ROOT', 'git://192.168.128.10')
#Autoproj.change_option('SPACEGIT_ROOT', 'git://192.168.128.10')
#Autoproj.change_option('SPACEGIT_PUSH_ROOT', 'git://192.168.128.10')
#Autoproj.change_option('GITHUB_ROOT', 'git://192.168.128.10')
#Autoproj.change_option('GITHUB_PUSH_ROOT', 'git://192.168.128.10')

Autoproj.env_inherit 'CMAKE_PREFIX_PATH'
#Autoproj.change_option('ROCK_FLAVOR', 'next') #THIS SHOULD NOT SET IN THIS FILE, so each user can select where he would like to work

Autobuild::Orogen.transports << "mqueue"
Autobuild::Orogen.extended_states = true

##We are using icecc
#if ENV['PATH'].include?("icecc")
#    STDOUT.puts "Increasing parralel build level to 50, because icecc is availible"
#    Autobuild.parallel_build_level = 50
#end
