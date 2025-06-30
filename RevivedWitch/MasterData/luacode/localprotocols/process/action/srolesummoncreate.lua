-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/srolesummoncreate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SRoleSummonCreate = require("localprotocols.def.action.srolesummoncreate")
SRoleSummonCreate.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SRoleSummonCreate Process")
  end
  controller:OnSRoleSummonCreate(self)
end

return SRoleSummonCreate

