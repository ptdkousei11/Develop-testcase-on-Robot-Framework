import paramiko

ssh = paramiko.SSHClient()
# Auto add host to known hosts
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

# Connect to server
ssh.connect("10.250.175.202", username="cmtg", password="cmtg")


def write_cmd(prompt, cmd):
    shell = ssh.invoke_shell()

    recv = b''
    char = ''

    def matcher(s): return prompt not in s

    while (matcher(char)):
        recv = shell.recv(1)
        char += bytes.decode(recv)

    recv = b''
    char = ''
    shell.sendall(cmd)

    while (matcher(char)):
        recv = shell.recv(1)
        char += bytes.decode(recv)

    return char


# Do command
print(write_cmd('cli>', b'aim service-unit show DHCP\n'))

# Close ssh connect
ssh.close()
