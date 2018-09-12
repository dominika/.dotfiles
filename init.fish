# environment variables
set -xg RAILS_ENV development
set -xg CHRUBY_ROOT /usr/local/opt/chruby

source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# prompt settings
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

# abbreviations / aliases
if not set -q abbrs_initialized
  set -U abbrs_initialized
  echo -n Setting abbreviations...
  abbr b "bundle exec"
  abbr bi 'bundle install'
  abbr c "bundle exec rails c 2>/dev/null"
  abbr ap "git pull and bi and mdb"
  abbr gs "git status"
  abbr gp "git pull"
  abbr gd "git diff"
  abbr gdc "git diff --cached"
  abbr gai "git add -i"
  abbr gap "git add -p"
  abbr gl "git log"
  abbr gcm "git checkout master"
  abbr gmm "git merge master"
  abbr gprune "git remote prune origin"
  abbr gplo "git pull origin (git_branch_name)"
  abbr gpuo "git push origin (git_branch_name)"
  abbr gst "git stash"
  abbr jb jobs
  abbr l 'ls -hF'
  abbr la 'ls -AhF'
  abbr ll 'ls -lhF'
  abbr lla 'ls -lAhF'
  abbr mdb "bundle exec rake db:migrate and RAILS_ENV=test bundle exec rake db:migrate"
  abbr pry "bundle exec pry-remote"
  abbr byebug "byebug -R localhost:8989"
  abbr q exit
  abbr r "bundle exec rails"
  abbr s "bundle exec rails s puma"
  abbr rk "bundle exec rake"
  abbr rr "bundle exec rake routes"
  abbr v vim
end
