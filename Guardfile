# A sample Guardfile
# More info at https://github.com/guard/guard#readme

group :backend do
  guard :bundler do
    watch('Gemfile')
  end

  guard :rspec, :cli => '--color --format doc' do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^support/.+\.rb$})
    watch(%r{^lib/(.+)\.rb$})         { |m| "spec/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')      { "spec" }
  end
end
