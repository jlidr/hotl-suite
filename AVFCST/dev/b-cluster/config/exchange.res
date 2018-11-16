resource exchange {
 protocol C;

 device /dev/drbd1; # Our drbd device, must match node1.
 disk /dev/xvdd;    # Partition drbd should use.
 meta-disk internal;

 on avf-ds-qb1 {
  address 10.239.60.20:7789; # IP address of node1, and port number.
 }

 on avf-ds-qb2 {
  address 10.239.60.40:7789; # IP address of node2, and port number.
 }
}
