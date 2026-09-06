local SRolePositionChange = require("localprotocols.def.action.srolepositionchange")

function SRolePositionChange:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SRolePositionChange Process")
  end
  if controller.OnSRolePositionChange then
    controller:OnSRolePositionChange(self)
  end
end

return SRolePositionChange
