# Sh::Cmd

Sh::Cmd is useful for constructing large Sh commands programmatically.
It also has the benefit of Shell escaping any args you pass.

## Usage:

``` ruby
cmd = Sh::Cmd.new("git") do |c|
  c.arg "log"
  c.opt "--oneline"
end

# OR

cmd = Sh::Cmd.new("git").arg("log").opt("--online")

puts cmd # => "git log --oneline"
```