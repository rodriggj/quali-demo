#!/bin/bash
echo "Copying the SSH Key to ELK Server"
echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEXtSHNDteXEuZk3gmHGYkO1hUOliUhlZoKH7Q6RnVBbejOc7NUu/9Kr3MXlvlBANlAlsd/qHXepqMZXXQXksWi1JetvaOrTcivOzD+1g4Ep3mk7JHcFriMaAK63+6QNMCOjqCKuSRNc9EoF8KXd/JXHIDiJ4R0LGyOXC0vzPmbgX708HemcRwk3AlMsKjBkrh9MQWENDCH73PX1I5uU09TJL9pt8QAoSv6nhKhLd7xCeUFAQzkITyqyhpnCoKCJiBuPJ9a72+oZ0EwIoUHiJkY29IjGvvzUqCCCwY/0DZCFFj+hcV/L2inWS2nKuY5cUNNAcNX5igaZVh/k1T744F gabrielrodriguez@QS-US-MB-GABE.local
" >> /home/.ssh/elk-key-pair.pub

echo "done"