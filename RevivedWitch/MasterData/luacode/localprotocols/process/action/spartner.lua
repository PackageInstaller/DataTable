-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/spartner.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SPartner = require("localprotocols.def.action.spartner")
SPartner.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SPartner Process")
  end
  if controller.OnSPartner then
    controller:OnSPartner(self)
  end
end

return SPartner

