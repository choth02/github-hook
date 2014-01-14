# github-hook

This is an internal gem at Plataformatec (<http://plataformatec.com.br>).

We use it to create and delete hooks in our github repositories (like campfire notifications for push and pull_request and CI integration with web push hooks).

## Configuration

First, create `~/.github-hook.yml` with

```yml
user: github_username
password: github_password
campfire_token: campfire_api_token
#optional api_url, default https://api.github.com
#api_url: https://mygithubenterprise/api/v3
```

Then you can use the command `github-hook` to list, create email, web and campfire hooks or delete them. Other hooks are not yet implemented (pull requests are appreciated!).

### Why I need to write my password?

The hook API is only accessible by the v3 Github API. There's a Oauth2 authentication method, but in order to use that you would need to set up a new application with Github, and then collect the token by an http callback (that must be accessible on the web). For the sake of simplicity, we use the other way to authenticate (http auth basic).

## Usage

The user specified MUST have administration rights for the repositories you want to set/delete hooks.

The available commands are:

```
$ github-hook
Tasks:
  github-hook help [TASK]                                                  # Describe available tasks or one specific task
  github-hook list user/repo                                               # List hooks in the given repository
  github-hook email user/repo events --address=ADDRESS                     # Add an email hook in the given repository. Events must be separated by commas.
  github-hook web user/repo events --url=URL                               # Add a web hook in the given repository. Events must be separated by commas.
  github-hook campfire user/repo events --room=ROOM --subdomain=SUBDOMAIN  # Add a campfire hook in the given repository. Events must be separated by commas.
  github-hook delete user/repo hook_number                                 # Delete the hook from the given repository
```

### List hooks

```
github-hook list plataformatec/devise 
```

### Create a new email hook

```
github-hook email plataformatec/devise "push" --address=email@mydomain.com
```

### Create a new web hook

```
github-hook web plataformatec/devise "pull_request, push" --url=http://mycallback.com/callback
```

This creates a new web hook that calls the url specified by `--url`. The events that this hooks listens must be the third argument and they must be separeted by commas. 

### Create a new campfire hook

```
github-hook campfire plataformatec/devise pull_request,push,issue_comment --room="My Room" --subdomain="My Subdomain"
```

Creates a new campfire hook. The token used for authentication with Campfire must be provided in your `~/.github-hook.yml` (see Configuration above).

### Delete a hook

```
github-hook delete plataformatec/devise 1010
```

Deletes the hook 1010 from the given repository. You can get the hook id from the url listed in `github-hook list user/repo`.

## Events

The available events that github gives us are:

Email events:
- push

Campfire events:

- push
- pull_request
- issues

Web events:

- push
- pull_request
- issues
- issue_comment

Github's documentation about hooks (http://developer.github.com/v3/repos/hooks/ and https://api.github.com/hooks) does not have all these hooks listed, but they are working with us.

## License

MIT License. Copyright 2012-2014 Plataformatec. http://plataformatec.com.br
