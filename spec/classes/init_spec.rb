# frozen_string_literal: true

require 'spec_helper'

describe 'rke' do
  it { is_expected.to compile.with_all_deps }
end
