local SRoleCreate = require("localprotocols.def.action.srolecreate")

function SRoleCreate:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SRoleCreate Process")
  end
  controller:OnSRoleCreate(self)
end

return SRoleCreate
