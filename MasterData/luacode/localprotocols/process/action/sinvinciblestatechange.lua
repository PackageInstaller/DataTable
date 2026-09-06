local SInvincibleStateChange = require("localprotocols.def.action.sinvinciblestatechange")

function SInvincibleStateChange:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SInvincibleStateChange Process")
  end
  if controller.OnSInvincibleStateChange then
    controller:OnSInvincibleStateChange(self)
  end
end

return SInvincibleStateChange
