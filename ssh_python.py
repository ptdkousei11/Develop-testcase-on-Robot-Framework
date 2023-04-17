import paramiko


def connect_to_ssh(address, usr, pwd):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(address, username=usr, password=pwd)


ssh = paramiko.SSHClient()

# Auto add host to known hosts
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

# Connect to server
ssh.connect("10.250.175.202", username="cmtg", password="cmtg")

# Do command
# (ssh_stdin, ssh_stdout, ssh_stderr) = ssh.exec_command("pwd")
ssh_stdin.write(answer + '\n')
ssh_stdin.flush()

# Get status code of command
exit_status = ssh_stdout.channel.recv_exit_status()

# Print status code
print("exit status: %s" % exit_status)

# Print content
for line in ssh_stdout.readlines():
    print(line.rstrip())

# Close ssh connect
ssh.close()
