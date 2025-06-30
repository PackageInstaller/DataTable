-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/supdaterolebuffs.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SUpdateRoleBuffs = require("localprotocols.def.action.supdaterolebuffs")
SUpdateRoleBuffs.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SUpdateRoleBuffs Process")
  end
  if controller.OnSUpdateRoleBuffs then
    controller:OnSUpdateRoleBuffs(self)
  end
end

return SUpdateRoleBuffs

