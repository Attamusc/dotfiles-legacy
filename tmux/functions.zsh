# ssh agent forwarding doesn't always work consistently.
# This function can be run in a resumed tmux session to make sure
# the ssh agent gets re-kicked
# Credit: https://blog.testdouble.com/posts/2016-11-18-reconciling-tmux-and-ssh-agent-forwarding/
muxssh() {
  eval $(tmux show-env -s |grep '^SSH_')
}
