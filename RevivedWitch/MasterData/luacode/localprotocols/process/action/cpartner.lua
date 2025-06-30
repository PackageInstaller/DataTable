-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/cpartner.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CPartner = require("localprotocols.def.action.cpartner")
CPartner.Process = function(self, battleWorld)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CPartner Process")
  end
  battleWorld:OnCPartner(self)
end

return CPartner

