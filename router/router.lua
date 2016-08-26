local turbo = require("turbo")


local ShellHandler = class("ShellHandler", turbo.web.RequestHandler)

local command = "intfunc"
cbt = {}

function bcb(result) 
  req = cbt['cb']    
  req:write( result )
  req:flush()
end

bash.register("bcb")



function ShellHandler:get()
    cbt['cb']=self
    local dstip = self:get_argument("dstip")
    print("got dstip arg: " .. dstip)
    bash.setVariable("dstip", dstip)
    bash.call(command)
end

local routeconfig = {}
function startwebapp(port)
    local routeconfig = {
        { "/shell", ShellHandler }
    }
   print("trying to start webapp at: " .. tonumber(port))
   turbo.web.Application(routeconfig):listen(tonumber(port))
   return 0
end

function registerHdlr(cmd)
  command = cmd
end


function startev() 
  turbo.ioloop.instance():start()
end
function stopev() 
  turbo.ioloop.instance():stop()
end


function redirections()
    repeat
        a = io.read()
        if a ~= nil then print("xx" .. a .. "xx") end
    until a == nil
end

function printenv()
    env = bash.getEnvironment()
    for key, val in pairs(env) do
        print(key .. "=" .. val)
    end
end


-- register shortcuts to functions above
bash.register("callbash")
bash.register("redirections")
bash.register("printenv")
bash.register("startwebapp")
bash.register("registerHdlr")
bash.register("startev")
bash.register("stopev")
