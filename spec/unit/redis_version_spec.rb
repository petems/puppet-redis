require 'spec_helper'

describe 'redis_version', type: :fact do
  before { Facter.clear }
  after { Facter.clear }

  it 'is 2.8.19 according to output' do
    Facter::Util::Resolution.stubs(:which).with('redis-server').returns('/usr/bin/redis-server')
    sample_redis_version = 'Redis server v=2.8.19 sha=00000000:0 malloc=jemalloc-3.6.0 bits=64 build=c0359e7aa3798aa2'
    Facter::Util::Resolution.stubs(:exec).with('redis-server --version').returns(sample_redis_version)
    expect(Facter.fact(:redis_version).value).to eq('2.8.19')
  end

  it 'is empty nil if redis not installed' do
    Facter::Util::Resolution.stubs(:which).with('redis-server').returns(nil)
    expect(Facter.fact(:redis_version).value).to eq(nil)
  end
end
