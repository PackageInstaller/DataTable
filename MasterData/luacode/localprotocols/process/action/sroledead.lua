local SRoleDead = require("localprotocols.def.action.sroledead")

function SRoleDead:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SRoleDead Process")
  end
  controller:OnSRoleDead(self)
end

return SRoleDead
