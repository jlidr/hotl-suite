resource mirror {
 protocol C;

 device /dev/drbd0; # Our drbd device, must match node0.
 disk /dev/xvdc;    # Partition drbd should use.
 meta-disk internal;

 on avf-ds-qb1 {
  address 10.239.60.20:7788; # IP address of node1, and port number.
 }

 on avf-ds-qb2 {
  address 10.239.60.40:7788; # IP address of node2, and port number.
 }
}
