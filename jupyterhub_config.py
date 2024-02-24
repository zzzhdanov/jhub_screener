import pwd, subprocess

c.JupyterHub.authenticator_class = 'nativeauthenticator.NativeAuthenticator'

c.Authenticator.admin_users = {'admin'}

def pre_spawn_hook(spawner):

    username = spawner.user.name

    try:

        pwd.getpwnam(username)

    except KeyError:

        subprocess.check_call(['useradd', '-ms', '/bin/bash', username])

        subprocess.check_call(['bash', '/jhub_screener/scripts/newuser.sh', username])

c.Spawner.pre_spawn_hook = pre_spawn_hook

c.Spawner.default_url = '/lab'