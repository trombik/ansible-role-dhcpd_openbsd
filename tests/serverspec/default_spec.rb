require "spec_helper"
require "serverspec"

package = ""
service = "dhcpd"
config  = "/etc/dhcpd.conf"

case os[:family]
when "freebsd"
  package = "net/dhcpd"
  config = "/usr/local/etc/dhcpd.conf"
end

if os[:family] != "openbsd"
  describe package(package) do
    it { should be_installed }
  end
end

describe file(config) do
  it { should be_file }
  its(:content) { should match(/^option domain-name "i\.trombik\.org";$/) }
end

case os[:family]
when "openbsd"
  describe command "rcctl get #{service} flags" do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should match(/^em0$/) }
  end
when "freebsd"
  describe file("/etc/rc.conf.d/dhcpd") do
    it { should exist }
    it { should be_file }
    it { should be_mode 644 }
    its(:content) { should match(/^dhcpd_flags="-c #{Regexp.escape(config)} em0"$/) }
  end
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end
