require "spec_helper"

class ServiceNotReady < StandardError
end

sleep 10 if ENV["JENKINS_HOME"]

context "after provisioning finished" do
  describe server(:client1) do
    it "should be able to ping server" do
      result = current_server.ssh_exec("ping -c 1 #{server(:server1).server.address} && echo OK")
      expect(result).to match(/OK/)
    end
  end

  describe server(:server1) do
    it "should be able to ping client" do
      result = current_server.ssh_exec("ping -c 1 #{server(:client1).server.address} && echo OK")
      expect(result).to match(/OK/)
    end
  end

  describe server(:client1) do
    it "shows em2 has not assigned any IP address" do
      result = current_server.ssh_exec("ifconfig em2")
      expect(result).not_to match(/^\s+inet 192\.168\.22\.100$/)
    end

    it "receives an IP address from DHCP server" do
      result = current_server.ssh_exec("sudo dhclient em2")
      expect(result).to match(/^DHCPDISCOVER on em2 to 255\.255\.255\.255 port 67 interval \d+$/)
      expect(result).to match(/^DHCPOFFER from 192\.168\.22\.200$/)
      expect(result).to match(/^DHCPREQUEST on em2 to 255\.255\.255\.255 port 67$/)
      expect(result).to match(/^DHCPACK from 192\.168\.22\.200$/)
      expect(result).to match(/^bound to 192\.168\.22\.100 -- renewal in 300 seconds\.$/)
    end
  end
end
