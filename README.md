hook.lua is a plugin for powerdns recursor

it requires lua-httpclient be installed
I have tested this with powerdns-recursor 4.0.0 alpha3 built against --with-luajit

router/ contains a bash http microservice that will add routes to the routing table
it should be run on the local machine or the forward router
