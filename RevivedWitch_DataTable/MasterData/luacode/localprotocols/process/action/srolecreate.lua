-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/srolecreate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SRoleCreate = require("localprotocols.def.action.srolecreate")
SRoleCreate.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SRoleCreate Process")
  end
  controller:OnSRoleCreate(self)
end

return SRoleCreate

