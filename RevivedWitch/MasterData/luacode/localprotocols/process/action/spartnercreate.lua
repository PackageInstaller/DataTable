-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/spartnercreate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SPartnerCreate = require("localprotocols.def.action.spartnercreate")
SPartnerCreate.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SPartnerCreate Process")
  end
  controller:OnSPartnerCreate(self)
end

return SPartnerCreate

