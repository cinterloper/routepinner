if [ "$gwip" == "" ]
then
  echo "you need to set the gwip variable" 1>&2
  exit -1
fi

startup_func () {
  cd /opt/routepinner
  pdns_recursor --config-dir=$(pwd) &
  cd router && source router.sh
}
healthcheck_func( ) {
  dig $TEST_HOST @localhost

}
