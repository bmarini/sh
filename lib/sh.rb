require "sh/version"
require "escape"

# Sh::Cmd is useful for constructing large Sh commands programmatically.
# It also has the benefit of Shell escaping any args you pass.
#
# Usage:
#
#     cmd = Sh::Cmd.new("git") do |c|
#       c.arg "log"
#       c.opt "--oneline"
#     end
#
#     # OR
#
#     cmd = Sh::Cmd.new("git").arg("log").opt("--online")
#
#     puts cmd # => "git log --oneline"

module Sh
  class Cmd
    def initialize(cmd="")
      @cmd, @args, @opts = cmd, [], []
      yield self if block_given?
    end

    def arg(*args)
      @args += args
      self
    end

    def opt(*opts)
      @opts += opts
      self
    end

    def to_s
      [ @cmd ].concat(@args).concat(@opts).map(&:to_s).map { |w| escape(w) }.join(' ')
    end

    def exec
      `#{self.to_s}`
    end

    # http://stackoverflow.com/questions/1306680/Shwords-Shescape-implementation-for-ruby-1-8
    def escape(str)
      Escape.shell_single_word(str).to_s
    end
  end
end
