def fixture_file(name)
  File.read(File.expand_path("../../../spec/fixtures/#{name}", __FILE__))
end

WebMock.stub_request(:get, "https://user:password@api.github.com/repos/user/repo/hooks").
  with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => fixture_file("list_hooks.json"), :headers => {})
