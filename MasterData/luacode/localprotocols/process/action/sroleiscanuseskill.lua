local SRoleIsCanUseSKill = require("localprotocols.def.action.sroleiscanuseskill")

function SRoleIsCanUseSKill:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SRoleIsCanUseSKill Process")
  end
  if controller.OnSRoleIsCanUseSKill then
    controller:OnSRoleIsCanUseSKill(self)
  end
end

return SRoleIsCanUseSKill
