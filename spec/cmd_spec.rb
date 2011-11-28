require "spec_helper"

describe Sh::Cmd do
  it "can build a shell command with a block" do
    cmd = Sh::Cmd.new("git") do |c|
      c.arg "log"
      c.opt "--oneline"
    end

    cmd.to_s.must_equal "git log --oneline"
  end

  it "can build a shell command with a chain" do
    cmd = Sh::Cmd.new("git").arg("log").opt("--oneline")
    cmd.to_s.must_equal "git log --oneline"
  end

  it "can string args and opts together in any order" do
    cmd = Sh::Cmd.new("git").arg("log").opt("--oneline").opt("decorate=full").arg("since...until").opt("--").arg("pathname")
    cmd.to_s.must_equal "git log --oneline decorate=full since...until -- pathname"
  end

  it "can take multiple args or opts at once" do
    cmd = Sh::Cmd.new("git").arg("log").opt("--oneline", "decorate=full").arg("since...until", "--", "pathname")
    cmd.to_s.must_equal "git log --oneline decorate=full since...until -- pathname"
  end
end

