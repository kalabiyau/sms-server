Gem::Specification.new do |s|
  s.name        = 'sms-server'
  s.version     = '1.0.0'
  s.date        = Time.now.strftime('%F')
  s.summary     = "SMS Server"
  s.description = "SCC Messaging Service server"
  s.authors     = ["Vladislav Lewin"]
  s.email       = 'vlewin@suse.de'
  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.executables << 'sms-server'
  s.homepage    = 'https://github.com/vlewin/sms-server'

  s.add_runtime_dependency 'sinatra'
  s.add_runtime_dependency 'sinatra-initializers'
  s.add_runtime_dependency 'redis'
  s.add_runtime_dependency 'redis-namespace'
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'psych'
  s.add_runtime_dependency 'haml'
  s.add_runtime_dependency 'minitest'
  s.add_runtime_dependency 'rack', '~> 1.4'
  s.add_runtime_dependency 'rack-test'
  s.add_runtime_dependency 'turn'
end
