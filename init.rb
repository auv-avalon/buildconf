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
# env_add 'PATH', "/path/to/my/tool"
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

def handle_gitorious_server(name, base_url)
    gitorious_long_doc = [
        "Access method to import data from #{base_url} (git, http or ssh)",
        "Use 'ssh' only if you have an account there. Note that",
        "ssh will always be used to push to the repositories, this is",
        "only to get data from the server. Therefore, we advise to use",
        "'git' as it is faster than ssh and better than http"]

    configuration_option name, 'string',
        :default => "git",
        :values => ["http", "ssh"],
        :doc => gitorious_long_doc do |value|

        if value == "git"
            Autoproj.change_option("#{name}_ROOT", "git://#{base_url}")
        elsif value == "http"
            Autoproj.change_option("#{name}_ROOT", "http://git.#{base_url}")
        elsif value == "ssh"
            Autoproj.change_option("#{name}_ROOT", "git@#{base_url}:")
        end

        value
    end

    Autoproj.change_option("#{name}_PUSH_ROOT", "git@#{base_url}:")
    Autoproj.user_config(name)
end

handle_gitorious_server('GITORIOUS', 'gitorious.com')
handle_gitorious_server('SPACEGIT', 'spacegit.dfki.uni-bremen.de')

Autoproj.env_inherit 'CMAKE_PREFIX_PATH'
Autoproj.change_option('ROCK_FLAVOR', 'master')

