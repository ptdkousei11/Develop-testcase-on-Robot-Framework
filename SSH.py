import paramiko
from robot.api.deco import library, keyword
from uuid import uuid4


@library(scope='GLOBAL')
class SSH():
    def __init__(self):
        self.ssh = paramiko.SSHClient()

    @keyword
    def set_session_id(self):
        self.session_id = uuid4()
        return self.session_id

    @keyword
    def connect(self, ip, username, password):
        self.ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        self.ssh.connect(hostname=ip, username=username,
                         password=password, timeout=30)
        self.shell = self.ssh.invoke_shell()
        self.sftp = self.ssh.open_sftp()
        session_id = self.set_session_id()
        return session_id

    @keyword
    def exec_cmd(self, cmd):
        (stdin, stdout, stderr) = self.ssh.exec_command(cmd)
        return "".join(stdout.readlines())

    @keyword
    def close_connect(self):
        self.ssh.close()

    @keyword
    def file_exists(self, path):
        self.sftp.chdir()
        try:
            self.sftp.stat(path)
            return 'File exists!'
        except IOError:
            return 'File do not exists!'

    @keyword
    def download_the_file(self, remote_path, local_path):
        self.sftp.get(remote_path, local_path)

    @keyword
    def create_folder(self, path):
        self.sftp.mkdir(path)

    @keyword
    def delete_folder(self, path):
        self.sftp.remove(path)

    @keyword
    def directory_exists(self, path):
        self.sftp.chdir()
        try:
            self.sftp.stat(path)
            return 'Directory exists'
        except IOError:
            return 'Directory not exists'

    @keyword
    def put_the_file(self, remote_path, local_path):
        self.sftp.put(remote_path, local_path)

    @keyword
    def write_cmd_with_prompt(self, prompt, cmd):
        self.shell.sendall(cmd)

        recv = b''
        char = ''

        def matcher(s): return prompt not in s

        while (matcher(char)):
            recv = self.shell.recv(1)
            char += bytes.decode(recv)

        self.shell.sendall('\n')

    @keyword
    def read_until_the_prompt(self, prompt):
        recv = b''
        char = ''

        def matcher(s): return prompt not in s

        while (matcher(char)):
            recv = self.shell.recv(1)
            char += bytes.decode(recv)

        return char

    @keyword
    def write_cmd(self, cmd):
        self.shell.sendall(cmd)
        self.shell.sendall('\n')
