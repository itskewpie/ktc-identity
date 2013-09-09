# vim: ft=sh:

@test "identity registered with etcd" {
  wget http://localhost:4001/v1/keys/services/memcached/members
}

@test "identity api is running" {
  netstat -tan | grep 5000
}

@test "identity admin is running" {
  netstat -tan | grep 35357
}
