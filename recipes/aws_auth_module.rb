# Cookbook Name:: nginx
# Recipe:: aws_auth_module
#
# Author:: Rodrigo Ribeiro (<rodriguinho@jusbrasil.com.br>)
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

include_recipe "git"

module_path = "#{Chef::Config['file_cache_path'] || '/tmp'}/ngx_aws_auth"

git module_path do 
  repository "https://github.com/jusbrasil/ngx_aws_auth.git"
  reference "master" 
  action :checkout
  destination module_path
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{module_path}"]
