-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sdestroyeffectbyname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SDestroyEffectByName = require("localprotocols.def.action.sdestroyeffectbyname")
SDestroyEffectByName.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SDestroyEffectByName Process")
  end
  if controller.OnSDestroyEffectByName then
    controller:OnSDestroyEffectByName(self)
  end
end

return SDestroyEffectByName

