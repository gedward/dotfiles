require "tmpdir"
require "colorize"

################################################################################
# Constants and helpers
################################################################################

COLORS = {
  red:    "1;31",
  yellow: "1;33",
  green: "0:32"
}

##
# Each key corresponds to a file in the +files+ directory, and each value is the
# destination of the symlink.
#
MAPPINGS = {
  "Xresources"         => "../.Xresources",
  "aliases"            => "../.aliases",
  "bash_aliases"       => "../.bash_aliases",
  "bashrc"             => "../.bashrc",
  "bin"                => "../bin",
  "gemrc"              => "../.gemrc",
  "gitconfig"          => "../.gitconfig",
  "gitignore_global"   => "../.gitignore_global",
  "itermcolors"        => "../.itermcolors",
  "rspec"              => "../.rspec",
  "tmux.conf"          => "../.tmux.conf",
  "tmuxinator"         => "../.tmuxinator",
  "vim"                => %w[../.vim ../.nvim],
  "vimrc"              => %w[../.vimrc ../.nvimrc],
  "vimrc.plugins"      => "../.vimrc.plugins",
  "xinitrc"            => "../.xinitrc",
  "zsh"                => "../.zsh",
}

PROCORE_MAPPINGS = {
  "procore/zsh/"     => "../.zsh",
  "procore/zshrc"    => "../.zshrc",
}

MAC_MAPPINGS = {
  "mac/zprofile"   => "../.zprofile",
  "mac/zshrc"      => "../.zshrc",
}

PREFERRED_SHELL = "zsh"

##
# Wraps Kernel#warn with support for colors.
#
alias :kernel_warn :warn
def warn(msg, color=:red)
  kernel_warn "\e[#{COLORS[color]}m#{msg}\e[m"
end

def force?
  @force ||= build_force
end

def build_force
  ENV["FORCE"] == "yes"
end

##
# Symlinks +src+ file or directory to +target+
#
def link_file(source, target)
  mapping_source = "./.dotfiles/files/#{source}"

  if File.exists?(target) && force?
    FileUtils.rm_rf(target)
  end

  if File.directory?(target)
    warn "#{target} is a directory. I'm not symlinking that unless you use FORCE=yes", :yellow
  else
    FileUtils.mkdir_p(File.dirname(target))
    puts "Symlinking #{source} to #{target}".green
    FileUtils.ln_s(mapping_source, target, force: force?)
  end
rescue
  warn "Couldn't create #{target} because it exists. Use `FORCE=yes` to overwrite."
end

def all_mappings
  if procore?
    MAPPINGS.merge(PROCORE_MAPPINGS)
  elsif mac?
    MAPPINGS.merge(MAC_MAPPINGS)
  else
    MAPPINGS
  end
end

def procore?
  ENV["PROCORE"] == "yes"
end

def mac?
  Gem::Platform.local.os == "darwin"
end

################################################################################
# Tasks
################################################################################

task default: :links

desc "Same as links, but overwrites any existing files."
task :force do
  ENV["FORCE"] = "yes"
  Rake::Task[:links].invoke
end

desc "Symlink config files to appropriate locations. (FORCE=yes to overwrite)"
task :links do
  all_mappings.each do |source, target|
    if target.is_a?(Array)
      target.each do |targetlet|
        link_file(source, targetlet)
      end
    else
      link_file(source, target)
    end
  end
end

# Because this may update the Rakefile, we depend on the update task, then we
# actually exec a call to rake in the shell.
desc "[Default] Update repository and run force task"
task :update_and_force do
  Rake::Task[:update].invoke
  exec "rake force" if $? == 0
end

desc "Update repository"
task :update do
  `git fetch --prune`
  `git pull --rebase origin HEAD`
end