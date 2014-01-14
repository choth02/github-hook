def stub_config!
  Github::Hook::Config.stub(:filename).and_return("/tmp/.github-hook.yml")
  FileUtils.touch(Github::Hook::Config.filename)
  Github::Hook::Config.stub(:config).and_return({ "user" => "user", "password" => "password", "campfire_token" => "token" })
end
