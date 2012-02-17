def stub_config!
  Github::Hooker::Config.stub(:config).and_return({ "user" => "user", "password" => "password", "campfire_token" => "token" })
end
