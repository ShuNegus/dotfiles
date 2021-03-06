#
# Executes commands at login post-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Execute code that does not affect the current session in the background.
{
    # Compile the completion dump to increase startup speed.
    dump_file="$HOME/.zcompdump"
    if [[ "$dump_file" -nt "${dump_file}.zwc" || ! -s "${dump_file}.zwc" ]]; then
        zcompile "$dump_file"
    fi

    # Set environment variables for launchd processes.
    if [[ "$OSTYPE" == darwin* ]]; then
        for env_var in PATH MANPATH; do
            if [ -x /usr/local/bin/reattach-to-user-namespace ]; then
                /usr/local/bin/reattach-to-user-namespace launchctl setenv "$env_var" "${(P)env_var}"
            else
                launchctl setenv "$env_var" "${(P)env_var}"
            fi
        done
    fi
} &!

# Print a random, hopefully interesting, adage.
#if (( $+commands[fortune] )); then
#    fortune -a
#    print
#fi


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
