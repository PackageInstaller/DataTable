-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/supdateroleattribute.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SUpdateRoleAttribute = require("localprotocols.def.action.supdateroleattribute")
SUpdateRoleAttribute.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SUpdateRoleAttribute Process")
  end
  if controller.OnSUpdateRoleAttribute then
    controller:OnSUpdateRoleAttribute(self)
  end
end

return SUpdateRoleAttribute

