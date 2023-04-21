import paramiko
from uuid import uuid4

ssh = paramiko.SSHClient()


# Auto add host to known hosts
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

# Connect to server
ssh.connect("10.250.175.202", username="cmtg", password="cmtg", timeout=30)

# Do something
(ssh_stdin, ssh_stdout, ssh_stderr) = ssh.exec_command('pwd')
print("".join(ssh_stdout.readlines()))

# Close ssh connect
ssh.close()
