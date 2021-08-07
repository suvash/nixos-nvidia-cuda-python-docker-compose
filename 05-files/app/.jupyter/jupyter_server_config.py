import os
app_dir = os.environ['APP_DIR']

c.ServerApp.ip = '0.0.0.0'
c.ServerApp.port = 8989
c.ServerApp.root_dir = f'{app_dir}/notebooks'
## Hashed password to use for web authentication.
#  To generate a new one, type in a python/IPython shell:
#    from jupyter_server.auth import passwd; passwd()
#  The string should be of the form type:salt:hashed-password.
#  Default: ''
c.ServerApp.password = 'argon2:$argon2id$v=19$m=10240,t=10,p=8$1eHk4Z6OMpGBWpZhNqCj2Q$cM9oLq1q2CqZ6y02iOF9/A'
