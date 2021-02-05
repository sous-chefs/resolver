node.default['resolver']['search'] = ['localdomain']
node.default['resolver']['domain'] = nil
node.default['resolver']['nameservers'] = %w(1.1.1.1 8.8.8.8)
node.default['resolver']['options'] = { 'timeout' => 2, 'rotate' => nil }
