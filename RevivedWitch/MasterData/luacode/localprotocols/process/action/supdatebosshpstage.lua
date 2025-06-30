-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/supdatebosshpstage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SUpdateBossHpStage = require("localprotocols.def.action.supdatebosshpstage")
SUpdateBossHpStage.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SUpdateBossHpStage Process")
  end
  if controller.OnSUpdateBossHpStage then
    controller:OnSUpdateBossHpStage(self)
  end
end

return SUpdateBossHpStage

