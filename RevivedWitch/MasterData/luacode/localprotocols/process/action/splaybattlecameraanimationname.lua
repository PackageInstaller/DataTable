-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/splaybattlecameraanimationname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SPlayBattleCameraAnimationName = require("localprotocols.def.action.splaybattlecameraanimationname")
SPlayBattleCameraAnimationName.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SPlayBattleCameraAnimationName Process")
  end
  if controller.OnSPlayBattleCameraAnimationName then
    controller:OnSPlayBattleCameraAnimationName(self)
  end
end

return SPlayBattleCameraAnimationName

