local SBreakOutPowerNumber = require("localprotocols.def.action.sbreakoutpowernumber")

function SBreakOutPowerNumber:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SBreakOutPowerNumber Process")
  end
  if controller.OnSBreakOutPowerNumber then
    controller:OnSBreakOutPowerNumber(self)
  end
end

return SBreakOutPowerNumber
