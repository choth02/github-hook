# github-hooker

This is an internal gem at PlataformaTec.

## Configuration

First, create ~/.github-hooker.yml with

```yml
user: github_username
password: github_password
campfire_token: campfire_api_token
```

Then you can use the command `github-hooker` to list, create web and campfire hooks or delete them. Other hooks are not yet implemented (pull requests are appreciated!).

## Usage

The user specified MUST have administration rights for the repositories you want to set/delete hooks.

### List hooks

```
github-hooker list plataformatec/devise 
```

### Create a new web hook

```
github-hooker web plataformatec/devise "pull_requests, push" --url=http://mycallback.com/callback
```

This creates a new web hook that calls the url specified by `--url`. The events that this hooks listens must be the third argument and they must be separeted by commas. 

### Create a new campfire hook

```
github-hooker campfire plataformatec/devise pull_requests,push,issue_comment --room="My Room" --subdomain="My Subdomain"
```

Creates a new campfire hook. The token used for authentication with Campfire must be provided in your `~/.github-hooker.yml` (see Configuration above).

### Delete a hook

```
github-hooker delete plataformatec/devise 1010
```

Deletes the hook 1010 from the given repository. You can get the hook id from the url listed in `github-hooker list user/repo`.


## License

upcoming!

