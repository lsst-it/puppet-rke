# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'rke class' do
  context 'without any parameters', :cleanup_opt do
    let(:manifest) do
      <<-PP
      include rke
      PP
    end

    it_behaves_like 'an idempotent resource'

    %w[
      /opt/rke
      /opt/rke/dl
      /opt/rke/dl/1.3.4
    ].each do |d|
      describe file(d) do
        it { is_expected.to be_directory }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to be_mode '755' }
      end
    end

    describe file('/opt/rke/dl/1.3.4/rke_linux-amd64') do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_mode '755' }
    end

    describe file('/usr/bin/rke') do
      it { is_expected.to be_symlink }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_linked_to '/opt/rke/dl/1.3.4/rke_linux-amd64' }
    end
  end

  context 'with base_path param' do
    basedir = default.tmpdir('rke')

    let(:manifest) do
      <<-PP
      class { rke:
        base_path => '#{basedir}',
      }
      PP
    end

    it_behaves_like 'an idempotent resource'

    [
      basedir,
      "#{basedir}/dl",
      "#{basedir}/dl/1.3.4",
    ].each do |d|
      describe file(d) do
        it { is_expected.to be_directory }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to be_mode '755' }
      end
    end

    describe file("#{basedir}/dl/1.3.4/rke_linux-amd64") do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_mode '755' }
    end

    describe file('/usr/bin/rke') do
      it { is_expected.to be_symlink }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_linked_to "#{basedir}/dl/1.3.4/rke_linux-amd64" }
    end
  end

  context 'with version related params' do
    let(:manifest) do
      <<-PP
      class { rke:
        version  => '1.3.3',
        checksum => '61088847d80292f305e233b7dff4ac8e47fefdd726e5245052450bf05da844aa',
      }
      PP
    end

    it_behaves_like 'an idempotent resource'

    %w[
      /opt/rke
      /opt/rke/dl
      /opt/rke/dl/1.3.3
    ].each do |d|
      describe file(d) do
        it { is_expected.to be_directory }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to be_mode '755' }
      end
    end

    describe file('/opt/rke/dl/1.3.3/rke_linux-amd64') do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_mode '755' }
    end

    describe file('/usr/bin/rke') do
      it { is_expected.to be_symlink }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_linked_to '/opt/rke/dl/1.3.3/rke_linux-amd64' }
    end
  end
end
