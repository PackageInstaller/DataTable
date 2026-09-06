local SBattleEnd = require("localprotocols.def.action.sbattleend")

function SBattleEnd:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SBattleEnd Process")
  end
  controller:OnSBattleEnd(self)
end

return SBattleEnd
