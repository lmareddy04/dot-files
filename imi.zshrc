# Synopys ENV module settings
source /global/etc/modules/$MODULE_VERSION/init/zsh

#
# History 
#
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=10000000

#setopt EXTENDED_HISTORY          # Save time info along with command
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.

#
# Modules
#
module load git/2.31.8
module load vim
module load tmux
module load meld
module load htop
module unload python/3.6.3

#
# Aliases
#
alias get_001_kitty="bsub -XF -app shared-0001 dbus-run-session kitty"
alias get_inter_kitty="bsub -XF -app shared-intQ dbus-run-session kitty"
alias switch_svc="sudo su - svc_imachines"
alias senv="source cfg/snps_migr/env.bash"
alias rp="realpath"
alias h="history"
alias c="clear"
alias szsh="source ~/.zshrc"
alias clean="make clean; make clean_push; rm -rf bsub*; rm -rf PUSH*; rm -rf verdiLog; rm -rf signal.rc; rm -rf novas* "

#
# Functions
#
function setprj {
  if [ -z "$1" ]; then
    export _repo_dir="$(basename "$PWD")";
  else
    export _repo_dir=$1;
  fi
  cd $WA/$_repo_dir*;
  source cfg/snps_migr/env.bash
  alias cdr="cd $REPO_ROOT"
  unset _repo_dir;
}

function waves {
  if [ -z "$1" ]; then
    export _fsdb_dir="$(ls -rt results/CORE/ae_run | tail -n 1)"
    export _fsdb_path=results/CORE/ae_run/$_fsdb_dir/novas.fsdb
  else
    export _fsdb_dir=$1
    export _fsdb_path=$_fsdb_dir/novas.fsdb
  fi
  echo "Opening waveform from: $_fsdb_path"
  verdi -nologo -ssf $_fsdb_path
  unset _fsdb_path;
  unset _fsdb_dir;
}

function tile_waves {
  if [ -z "$1" ]; then
    export _fsdb_dir="$(ls -rt results/CPU_TILE/ae_run | tail -n 1)"
    export _fsdb_path=results/CPU_TILE/ae_run/$_fsdb_dir/novas.fsdb
  else
    export _fsdb_dir=$1
    export _fsdb_path=$_fsdb_dir/novas.fsdb
  fi
  echo "Opening waveform from: $_fsdb_path"
  verdi -nologo -ssf $_fsdb_path
  unset _fsdb_path;
  unset _fsdb_dir;
}

function failed_tests {
  if [ -z "$1" ]; then
    export _regr_root=$PWD
  else
    export _regr_root=$1
  fi

  for dir in $_regr_root/*; do 
    if [ ! -f $dir/PASS ] && [ ! -f $dir/PASS ]; then
      echo $dir
    fi
  done
  unset _regr_root;
}

function failed_push_tests {
  if [ -z "$1" ]; then
    export _regr_root=$PWD
  else
    export _regr_root=$1
  fi
  failed_tests $_regr_root/results/CORE/ae_run
  failed_tests $_regr_root/results/CPU_TILE/ae_run
  failed_tests $_regr_root/results/MEM_TB/ae_run
  unset _regr_root;
}

function pushq_status {
  echo "Current Push reservations"
  #bjobs -u all | rg --ignore-case PUSH_reser
  bjobs -u all -o "JOBID: user:15 name:25 stat: submit_time:15 start_time:15 run_time:15 Application: queue:15 mem::MB max_mem::MB cpu_peak" -J push_reservation
  echo
  echo "Current Regression status"
  export _pend_jobs=$(bjobs -u all | rg PUSH_REGR | rg PEND | wc -l)
  export _run_jobs=$(bjobs -u all | rg PUSH_REGR | rg RUN | wc -l)
  echo "Pending Jobs: $_pend_jobs       Running Jobs: $_run_jobs"
  echo 
  if [ "$1" = "full" ]; then
    bjobs -u all -o "JOBID: user:15 name:25 stat: submit_time:15 start_time:15 run_time:15 Application: queue:15 mem::MB max_mem::MB cpu_peak" -J PUSH_REGR
  fi
  unset _pend_jobs;
  unset _run_jobs;
}

function wait_push {
  export _num_jobs=$(bjobs -u all | rg --ignore-case PUSH_reser | wc -l)
  if [ "$_num_jobs" = "0" ]; then
    make push
  else
    echo "pushq is busy"
    sleep 30;
    wait_push
  fi
  unset _num_jobs;
}

#
# Tmux Section
#
export TMUX_TMPDIR=/SCRATCH/$USER/tmp

#
#My tools
#
export MY_TOOLS=/projects/lmareddy/tools
export PATH=$MY_TOOLS/bat:$PATH
export PATH=$MY_TOOLS/exa/bin:$PATH
export PATH=$MY_TOOLS/fd:$PATH
export PATH=$MY_TOOLS/fasder:$PATH
export PATH=$MY_TOOLS/fzf/bin:$PATH
export PATH=$MY_TOOLS/kitty/bin:$PATH
export PATH=$MY_TOOLS/ncdu:$PATH
export PATH=$MY_TOOLS/ripgrep:$PATH
export PATH=$MY_TOOLS/zoxide:$PATH

#
#Place for custom scripts
#
export PATH=$MY_TOOLS/bin:$PATH

#
#setup Zoxide
#
eval "$(zoxide init zsh)"
alias cd="z"

#
# Setup fzf
#
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

