import paramiko


def write_cmd_with_prompt(prompt, cmd):
    shell = ssh.invoke_shell()
    shell.sendall(cmd)
    shell.sendall('\n')

    recv = b''
    char = ''

    def matcher(s): return prompt not in s

    while (matcher(char)):
        recv = shell.recv(1)
        char += bytes.decode(recv)

    return char


def read_until_the_prompt(prompt):
    shell = ssh.invoke_shell()

    recv = b''
    char = ''

    def matcher(s): return prompt not in s

    while (matcher(char)):
        recv = shell.recv(1)
        char += bytes.decode(recv)

    return char


def exec_cmd(cmd):
    (ssh_stdin, ssh_stdout, ssh_stderr) = ssh.exec_command(cmd)
    return "".join(ssh_stdout.readlines())


ssh = paramiko.SSHClient()
# Auto add host to known hosts
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

# Connect to server
ssh.connect("10.91.0.62", username="root", password="y6U&i8o9", timeout=30)

# Write command
shell = ssh.invoke_shell()
shell.sendall('telnet localhost 6669\n')
shell.sendall('\n')

recv = b''
char = ''

prompt = '>'


def matcher(s): return prompt not in s


while (matcher(char)):
    recv = shell.recv(1)
    char += bytes.decode(recv)

print(char)

shell.sendall('act-user::root:::y6U&i8o9;')
shell.sendall('\n')

recv = b''
char = ''

prompt = '>'


def matcher(s): return prompt not in s


while (matcher(char)):
    recv = shell.recv(1)
    char += bytes.decode(recv)

print(char)

# Close ssh connect
ssh.close()
