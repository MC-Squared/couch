guard :shell do
  watch(/couch.rb/) { system('ruby couch.rb') }
  watch(%r{^lib/.+/.+\.rb}) { system('ruby couch.rb') }
end
