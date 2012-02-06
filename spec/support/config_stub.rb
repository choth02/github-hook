def stub_config!
  Github::Hooker.stub(:config).and_return({ "user" => "user", "password" => "password", "campfire_token" => "token" })
end
