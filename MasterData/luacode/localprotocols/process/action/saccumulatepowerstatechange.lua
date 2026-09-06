local SAccumulatePowerStateChange = require("localprotocols.def.action.saccumulatepowerstatechange")

function SAccumulatePowerStateChange:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SAccumulatePowerStateChange Process")
  end
  if controller.OnSAccumulatePowerStateChange then
    controller:OnSAccumulatePowerStateChange(self)
  end
end

return SAccumulatePowerStateChange
