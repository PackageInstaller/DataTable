-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sroledead.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SRoleDead = require("localprotocols.def.action.sroledead")
SRoleDead.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SRoleDead Process")
  end
  controller:OnSRoleDead(self)
end

return SRoleDead

