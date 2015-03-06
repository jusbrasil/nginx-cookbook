# Cookbook Name:: nginx
# Recipe:: ngx_pagespeed
#
# Author:: JusBrasil Team (<dev@jusbrasil.com.br>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

NPS_VERSION="1.9.32.3"

nginx_path = "#{Chef::Config['file_cache_path'] || '/tmp'}"
module_path = "#{nginx_path}/ngx_pagespeed-release-#{NPS_VERSION}-beta"

remote_file "#{module_path}.zip" do
	source "https://github.com/pagespeed/ngx_pagespeed/archive/release-#{NPS_VERSION}-beta.zip"
end

bash "unzip ngx_pagespeed" do
		code %(unzip -uo #{module_path}.zip)
		cwd nginx_path
		user "root"
		group "root"
end

remote_file "/tmp/psol-#{NPS_VERSION}.tar.gz" do
	source "https://dl.google.com/dl/page-speed/psol/#{NPS_VERSION}.tar.gz"
end

bash "unzip psol" do
		code %(tar -xzvf /tmp/psol-#{NPS_VERSION}.tar.gz)
		cwd module_path
		user "root"
		group "root"
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{module_path}"]
