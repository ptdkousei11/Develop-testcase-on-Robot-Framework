import paramiko


def write_cmd_with_prompt(prompt, cmd):
    shell = ssh.invoke_shell()
    shell.sendall(cmd)

    recv = b''
    char = ''

    def matcher(s): return prompt not in s

    while (matcher(char)):
        recv = shell.recv(1)
        char += bytes.decode(recv)

    return char


ssh = paramiko.SSHClient()
# Auto add host to known hosts
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

# Connect to server
ssh.connect("10.91.0.62", username="root", password="y6U&i8o9", timeout=30)

stdin, stdout, stderr = ssh.exec_command('telnet localhost 6669')
print("".join(stdout.readlines()))
exit = stdout.channel.recv_exit_status()
print('Exit status ', exit)

# Close ssh connect
ssh.close()
