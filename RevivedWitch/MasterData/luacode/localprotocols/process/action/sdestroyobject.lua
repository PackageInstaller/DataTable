-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sdestroyobject.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SDestroyObject = require("localprotocols.def.action.sdestroyobject")
SDestroyObject.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SDestroyObject Process")
  end
  controller:OnSDestroyObject(self)
end

return SDestroyObject

