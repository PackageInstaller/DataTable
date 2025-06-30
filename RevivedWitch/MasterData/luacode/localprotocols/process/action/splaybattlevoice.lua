-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/splaybattlevoice.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SPlayBattleVoice = require("localprotocols.def.action.splaybattlevoice")
SPlayBattleVoice.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SPlayBattleVoice Process")
  end
  if controller.OnSPlayBattleVoice then
    controller:OnSPlayBattleVoice(self)
  end
end

return SPlayBattleVoice

