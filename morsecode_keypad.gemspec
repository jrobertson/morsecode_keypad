Gem::Specification.new do |s|
  s.name = 'morsecode_keypad'
  s.version = '0.1.0'
  s.summary = 'Designed for using morsecode on the Raspberry Pi with a keypad which has 4 buttons (dash, dot, separator, and send).'
  s.authors = ['James Robertson']
  s.files = Dir['lib/morsecode_keypad.rb']
  s.add_runtime_dependency('rpi_pinin', '~> 0.1', '>=0.1.2')
  s.signing_key = '../privatekeys/morsecode_keypad.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/morsecode_keypad'
end
