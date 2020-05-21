# frozen_string_literal: true

describe Facts::Linux::Hypervisors do
  describe '#call_the_resolver' do
    subject(:fact) { Facts::Linux::Hypervisors.new }

    before do
      allow(Facter::Resolvers::DockerLxc).to \
        receive(:resolve).with(:hypervisor).and_return(hv)
    end

    context 'when resolver returns docker' do
      let(:hv) { { 'docker' => { 'id' => 'testid' } } }

      it 'calls Facter::Resolvers::DockerLxc' do
        fact.call_the_resolver
        expect(Facter::Resolvers::DockerLxc).to have_received(:resolve).with(:hypervisor)
      end

      it 'returns virtual fact' do
        expect(fact.call_the_resolver).to be_an_instance_of(Facter::ResolvedFact).and \
          have_attributes(name: 'hypervisors', value: hv)
      end
    end

    context 'when resolver returns lxc' do
      let(:hv) { { 'lxc' => { 'name' => 'test_name' } } }

      it 'calls Facter::Resolvers::DockerLxc' do
        fact.call_the_resolver
        expect(Facter::Resolvers::DockerLxc).to have_received(:resolve).with(:hypervisor)
      end

      it 'returns virtual fact' do
        expect(fact.call_the_resolver).to be_an_instance_of(Facter::ResolvedFact).and \
          have_attributes(name: 'hypervisors', value: hv)
      end
    end

    context 'when resolver returns nil' do
      let(:hv) { nil }

      it 'returns virtual fact as nil' do
        expect(fact.call_the_resolver).to be_an_instance_of(Facter::ResolvedFact).and \
          have_attributes(name: 'hypervisors', value: hv)
      end
    end
  end
end
