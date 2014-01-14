def stub_config!
  Github::Hook::Config.stub(:config).and_return({ "user" => "user", "password" => "password", "campfire_token" => "token" })
end
