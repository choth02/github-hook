# github-hook

This is an internal gem at Plataformatec (<http://plataformatec.com.br>).

We use it to create and delete hooks in our github repositories (like campfire notifications for push and pull_request and CI integration with web push hooks).

## Configuration

First, create `~/.github-hook.yml` with

```yml
user: github_username
password: github_personal_access_token_see_below
campfire_token: campfire_api_token
#optional api_url, default https://api.github.com
#api_url: https://mygithubenterprise/api/v3
```

Then you can use the command `github-hook` to list, create email, web and campfire hooks or delete them. Other hooks are not yet implemented (pull requests are appreciated!).

### How to create Personal Access Token

Go to the [Authorized Applications](https://github.com/settings/applications) page and click "Create new token" under "Personal Access Tokens".

## Usage

The user specified MUST have administration rights for the repositories you want to set/delete hooks.

The available commands are:

```
$ github-hook
Tasks:
  github-hook help [TASK]                                                  # Describe available tasks or one specific task
  github-hook list user/repo                                               # List hooks in the given repository
  github-hook email user/repo events --address=ADDRESS                     # Add an email hook in the given repository. Events must be separated by commas.
  github-hook web user/repo events --url=URL --content-type=json           # Add a web hook in the given repository. Events must be separated by commas. Content type defaults to form encoded.
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
github-hook web plataformatec/devise "pull_request, push" --url=http://mycallback.com/callback --content-type=json
```

This creates a new web hook that calls the url specified by `--url` with a content type of json. The events that this hooks listens must be the third argument and they must be separated by commas.

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
