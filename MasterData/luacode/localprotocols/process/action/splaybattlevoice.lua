local SPlayBattleVoice = require("localprotocols.def.action.splaybattlevoice")

function SPlayBattleVoice:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SPlayBattleVoice Process")
  end
  if controller.OnSPlayBattleVoice then
    controller:OnSPlayBattleVoice(self)
  end
end

return SPlayBattleVoice
