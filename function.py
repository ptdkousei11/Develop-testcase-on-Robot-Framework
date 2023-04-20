import paramiko
global ssh


def init():
    global ssh
    ssh = paramiko.SSHClient()


def connect(ip, username, password):
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(hostname=ip, username=username,
                password=password, timeout=30)


def exec_cmd(cmd):
    (ssh_stdin, ssh_stdout, ssh_stderr) = ssh.exec_command(cmd)
    return "".join(ssh_stdout.readlines())


def close_connect():
    ssh.close()


def file_exists(path):
    sftp = ssh.open_sftp()
    sftp.chdir()
    try:
        sftp.stat(path)
        return 'File exists!'
    except IOError:
        return 'File do not exists!'


def download_the_file(remote_path, local_path):
    sftp = ssh.open_sftp()
    sftp.get(remote_path, local_path)


def create_folder(path):
    sftp = ssh.open_sftp()
    sftp.mkdir(path)


def delete_folder(path):
    sftp = ssh.open_sftp()
    sftp.remove(path)


def directory_exists(path):
    sftp = ssh.open_sftp()
    sftp.chdir()
    try:
        sftp.stat(path)
        return 'Directory exists'
    except IOError:
        return 'Directory not exists'


def put_the_file(remote_path, local_path):
    sftp = ssh.open_sftp()
    sftp.put(remote_path, local_path)


def exec_cmd_with_prompt(prompt, cmd):
    shell = ssh.invoke_shell()

    recv = b''
    char = ''

    def matcher(s): return prompt not in s

    while (matcher(char)):
        recv = shell.recv(1)
        char += bytes.decode(recv)

    shell.sendall(cmd)

    recv = b''
    char = ''

    while (matcher(char)):
        recv = shell.recv(1)
        char += bytes.decode(recv)

    return char


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


def read_until_the_prompt(prompt):
    shell = ssh.invoke_shell()

    recv = b''
    char = ''

    def matcher(s): return prompt not in s

    while (matcher(char)):
        recv = shell.recv(1)
        char += bytes.decode(recv)

    return char


def write_cmd(cmd):
    shell = ssh.invoke_shell()
    return shell.send(cmd)
