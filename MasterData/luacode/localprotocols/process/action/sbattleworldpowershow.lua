local SBattleWorldPowerShow = require("localprotocols.def.action.sbattleworldpowershow")

function SBattleWorldPowerShow:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SBattleWorldPowerShow Process")
  end
  if controller.OnSBattleWorldPowerShow then
    controller:OnSBattleWorldPowerShow(self)
  end
end

return SBattleWorldPowerShow
