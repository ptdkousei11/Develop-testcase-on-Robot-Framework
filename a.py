import paramiko

ssh = paramiko.SSHClient()
# Auto add host to known hosts
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

# Connect to server
ssh.connect("10.91.0.62", username="root", password="y6U&i8o9")


# Do command
(ssh_stdin, ssh_stdout, ssh_stderr) = ssh.exec_command('cli')

# Get status code of command
exit_status = ssh_stdout.channel.recv_exit_status()

# Print status code
print("exit status: %s" % exit_status)

# Print content
print("".join(ssh_stdout.readlines()))

# Close ssh connect
ssh.close()
