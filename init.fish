# +-----------------------------------------------------------------------------+
# |                                                                             |
# +-----------------------------------------------------------------------------+

# +-----------------------------------------------------------------------------+
# | Environment variables                                                       |
# +-----------------------------------------------------------------------------+
# +---- rails
set -xg RAILS_ENV development
set -xg CHRUBY_ROOT /usr/local/opt/chruby
# +---- vim plugin for ctags
set -xg DEP_PROJECT_REG '[admin|engine]'
set -xg DEP_PROJECT ~/bgl/gaming_worker
# +---- machine configuration script
set -xg DOT_FILES ~/.dotfiles
set -xg BREW_FILES_PATH ~/.brewFiles
# +---- utility
set -xg MANPAGER 'col -bx | vim -c ":set ft=man nonu nolist" -R -'
set -xg EDITOR vim
set -xg LANG en_US.UTF-8

set -xg PATH $PATH /Users/deszczowiec/Library/Python/3.6/bin

if [ -f '/Users/deszczowiec/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/deszczowiec/Downloads/google-cloud-sdk/path.fish.inc'; end

source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# +-----------------------------------------------------------------------------+
# | Prompt settings                                                             |
# +-----------------------------------------------------------------------------+
set -g theme_display_hg no
set -g theme_display_ruby yes
set -g theme_display_user no
set -g theme_display_vi no
set -g theme_display_date no
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts no
set -g theme_show_exit_status yes
set -g theme_color_scheme solarized
set -g fish_prompt_pwd_dir_length 1
set -g theme_project_dir_length 1
set -g theme_newline_cursor yes
set -U fish_color_autosuggestion white

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
  echo (set_color blue) 'Updating rubygems  -------------------------------------------------' (set_color normal)
  gem update --system
  chruby 2.5.1
  echo (set_color blue) 'Updating bundler   -------------------------------------------------' (set_color normal)
  gem install bundler --no-document
  #gem cleanup -V
  echo (set_color blue) 'Updating homebrew packages -----------------------------------------'  (set_color normal)
  cd $DOT_FILES
  ls -d1 $BREW_FILES_PATH/* | xargs -n1 bash -c 'brew bundle --file=$0'
  brew doctor
  echo (set_color blue) 'Upgrading vim & plugins --------------------------------------------' (set_color normal)
  vim +PlugUpgrade +PlugUpdate +qall
end

function latest_and_set_up --description 'updates all the (project) things'
  git stash
  git pull
  dotenv2 .env
  bundle install
  generate_ctags (basename (pwd)) with_gems
  bundle exec rake db:migrate && env RAILS_ENV=test bundle exec rake db:migrate
end
