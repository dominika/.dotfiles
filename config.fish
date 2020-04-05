# +-----------------------------------------------------------------------------+
# |                                                                             |
# +-----------------------------------------------------------------------------+

# +-----------------------------------------------------------------------------+
# | Environment variables                                                       |
# +-----------------------------------------------------------------------------+
# +---- utility
set -xg MANPAGER 'col -bx | vim -c ":set ft=man nonu nolist" -R -'
set -xg EDITOR vim
set -xg LANG en_US.UTF-8

[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# +-----------------------------------------------------------------------------+
# | Prompt settings                                                             |
# +-----------------------------------------------------------------------------+
set -g theme_display_hg no
set -g theme_display_ruby no
set -g theme_display_user no
set -g theme_display_vi no
set -g theme_display_date no
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts no
set -g theme_show_exit_status yes
set -g theme_color_scheme solarized
set -g fish_prompt_pwd_dir_length 1
set -g theme_project_dir_length 1
set -g theme_newline_cursor no
set -U fish_color_autosuggestion black

# +-----------------------------------------------------------------------------+
# | Abbreviations and aliases                                                   |
# +-----------------------------------------------------------------------------+
if not set -q abbrs_initialized
  set -U abbrs_initialized
  echo -n Setting abbreviations...
  abbr b "bundle exec"
  abbr bi 'bundle install'
  abbr r "bundle exec rails"
  abbr s "bundle exec rails s puma"
  abbr c "bundle exec rails c 2>/dev/null"
  abbr gs "git status"
  abbr gp "git pull"
  abbr gd "git diff"
  abbr gdc "git diff --cached"
  abbr gai "git add -i"
  abbr gap "git add -p"
  abbr gl "git log"
  abbr gcm "git checkout master"
  abbr gcb "git checkout -b"
  abbr gmm "git merge master"
  abbr gprune "git remote prune origin"
  abbr gplo "git pull origin (git_branch_name)"
  abbr gpso "git push origin (git_branch_name)"
  abbr gst "git stash"
  abbr jb jobs
  abbr l 'ls -hF'
  abbr la 'ls -AhF'
  abbr ll 'ls -lhF'
  abbr lla 'ls -lAhF'
  abbr mdb "bundle exec rake db:migrate and env RAILS_ENV=test bundle exec rake db:migrate"
  abbr pry "bundle exec pry-remote"
  abbr byebug "byebug -R localhost:8989"
  abbr q exit
  abbr v vim
end

# +-----------------------------------------------------------------------------+
# | Functions                                                                   |
# +-----------------------------------------------------------------------------+
function break_things_for_me --description 'updates all the (system) things: gems, packages, vim plugins'
  echo (set_color blue) 'Updating omf  ------------------------------------------------------' (set_color normal)
  omf update
  echo (set_color blue) 'Updating homebrew packages -----------------------------------------'  (set_color normal)
  cd
  brew bundle
  brew doctor
  cd -
  echo (set_color blue) 'Upgrading vim & plugins --------------------------------------------' (set_color normal)
  vim +PlugUpgrade +PlugUpdate +qall
end
