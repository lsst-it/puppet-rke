# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'rke class' do
  context 'without any parameters', :cleanup_opt do
    let(:pp) do
      <<-EOS
      include rke
      EOS
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
  end

  context 'with base_path param' do
    basedir = default.tmpdir('rke')

    let(:pp) do
      <<-EOS
      class { rke:
        base_path => '#{basedir}',
      }
      EOS
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
  end
end
