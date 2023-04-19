import paramiko
import os


def connect_to_ssh(address, usr, pwd):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(address, username=usr, password=pwd)


def file_exists(path):
    sftp = ssh.open_sftp()
    sftp.chdir()
    try:
        sftp.stat(path)
        print('file exists')
    except IOError:
        print('file not exists')


def create_folder(path):
    sftp = ssh.open_sftp()
    sftp.mkdir(path)


def delete_folder(path):
    sftp = ssh.open_sftp()
    sftp.rmdir(path)


def put_the_file(remote_path, local_path):
    sftp = ssh.open_sftp()
    sftp.get(remote_path, local_path)


ssh = paramiko.SSHClient()
# Auto add host to known hosts
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

# Connect to server
ssh.connect("10.250.176.6", username="nthuong2", password="Huong@123")
sftp = ssh.open_sftp()
# create_folder('/home/nthuong2/temp')
# print(sftp.stat('/home/nthuong2/temp'))
# delete_folder('/home/nthuong2/temp')
put_the_file('/home/nthuong2/temp/runtest.sh', 'runtest.sh')


# file_exists('/home/nthuong2/runtest.sh')

# Do command
# (ssh_stdin, ssh_stdout, ssh_stderr) = ssh.exec_command("pwd")

# Get status code of command
# exit_status = ssh_stdout.channel.recv_exit_status()


# Print status code
# print("exit status: %s" % exit_status)

# Print content
# print("".join(ssh_stdout.readlines()))

# Close ssh connect
ssh.close()
