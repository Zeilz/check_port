import socket
from time import time, sleep
from requests import post


def check_host(host_ip: str, host_port: int) -> bool:
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    result = sock.connect_ex((host_ip, host_port))
    if result != 0:
        return False
    return True


def read_file() -> dict:
    with open('test.txt', 'r', encoding='utf-8') as ip_file:
        host_dict = dict()
        for line in ip_file:
            host_ip, host_port = line.split(':')
            if host_ip not in host_dict.keys():
                host_dict[host_ip] = int(host_port)
        return host_dict


def send_report(host_ip: str, host_port: int) -> None:
    url = 'https://www.w3schools.com/python/demopage.php'
    data = {'failed': '{ip}:{port}'.format(ip=host_ip, port=host_port)}
    post(url, data=data)


while True:
    ip_dict = read_file()
    for ip, port in ip_dict.items():
        if not check_host(ip, port):
            send_report(ip, port)
    sleep(60 - time() % 60)
