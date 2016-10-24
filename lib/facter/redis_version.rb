# Fact: redis_version
#
# Purpose: Retrieve collectd version if installed
#
# Resolution:
#
# Caveats:  not well tested
#
Facter.add(:redis_version) do
  setcode do
    if Facter::Util::Resolution.which('redis-server')
      redis_version = Facter::Util::Resolution.exec('redis-server --version')
      %r{v=([\w\.]+)}.match(redis_version)[1]
    end
  end
end
