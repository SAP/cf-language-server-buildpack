# Cloud Foundry Java Buildpack
# Copyright (c) 2013 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'spec_helper'
require 'tmpdir'

describe JavaBuildpack::Compile do

  before do
    $stdout = StringIO.new
    $stderr = StringIO.new
  end

  it 'should extract Java from a GZipped TAR' do
    JavaBuildpack::JreSelector.any_instance.stub(:uri).and_return('spec/fixtures/stub-java.tar.gz')

    Dir.mktmpdir do |root|
      FileUtils.cp_r "spec/fixtures/single_system_properties/.", root
      JavaBuildpack::Compile.new(root, Dir.tmpdir).run

      java = File.join(root, '.java', 'bin', 'java')
      expect(File.exists?(java)).to be_true
    end
  end

end