
local ZBS = "E:/Unity3D/Test/Lua/ulua_debugger_demo-master/ZeroBraneStudio/lualibs/mobdebug/";
LuaMgr.Instance:AddLuaSearchPath(ZBS)
require("mobdebug").start(DebugServerIp)
