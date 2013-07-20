#
# Cookbook Name:: resolver
# Recipe:: from_search
#
# Copyright 2013, Erick Turnquist <jhujhiti@adjectivism.org>
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
#

# execute the query. we use String#% to allow #{} interpolation here
# reduce each returned hash to just the k/v we're looking for (keep_if)
# extract just the values, discarding the keys (values)
# flatten that array to make sure it can be used as expected in the template (flatten)
nameservers = search(:node, "%s" % [ node["resolver"]["search_query"] ]).map do |n|
    n.to_hash.keep_if do |a,b|
        node["resolver"]["search_attributes"].member?(a)
    end.values()
end.flatten()

# search() does not produce deterministic results
# we don't want to just sort them -- that might result in unbalanced load
# so, use Array#shuffle with a reasonably constant seed, too
# we'll actually use an md5 hash of that as the seed
nameservers = nameservers.sort!()
require "digest/md5"
seed = Digest::MD5.hexdigest(node["hostname"]).to_i(16)
nameservers = nameservers.shuffle!(random: Random.new(seed))

template "/etc/resolv.conf" do
  source "resolv.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    'search' => node['resolver']['search'],
    'nameservers' => nameservers,
    'options' => node['resolver']['options']
  )
end
