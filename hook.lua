
pdnslog("pdns-recursor Lua script starting!", pdns.loglevels.Warning)

routeset = newDS()
routeset:add{"example.com"}
function postresolve(dq)
	print("postresolve called for ",dq.qname:toString())
	print("lua path:", package.path)
	local records = dq:getRecords()
	for k,v in pairs(records) do
		if routeset:check(dq.qname) and v.type == pdns.A then
			local hc = require('httpclient').new()
			local res = hc:get('http://localhost:8992/shell?dstip=' .. v:getContent())
			if res.body then
			  pdnslog(res.body)
			else
			  pdnslog(res.err)
			end
		end
	end
	dq:setRecords(records)
	return true
end
