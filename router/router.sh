#!/bin/bash
# This is a simple lua bash example.

# init lua bash and load code chunk from file internal.lua.


# bash function to be called from within lua context

#gwip=PUT YOUR GATEWAY IP here to pin hosts to
VARS=( CONFIGDIR )

VARS=( gwip )

 for var in ${VARS[@]}
 do
  if [  "$(eval echo \$"$var")" == "" ]
  then
    echo "$var not set, cannot continue"
    die
  fi
 done



intfunc () {

   RES="$(sudo /sbin/ip route add $dstip via $gwip 2>&1 | base64 -w 0 )"
   bcb $RES
}
export -f intfunc



luabash load ./router.lua

die () {
 stopev
 kill -9 1
}
trap die 0 1 2 3 15



registerHdlr intfunc
startwebapp 8992 
startev 

