-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/srolepositionchange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SRolePositionChange = require("localprotocols.def.action.srolepositionchange")
SRolePositionChange.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SRolePositionChange Process")
  end
  if controller.OnSRolePositionChange then
    controller:OnSRolePositionChange(self)
  end
end

return SRolePositionChange

