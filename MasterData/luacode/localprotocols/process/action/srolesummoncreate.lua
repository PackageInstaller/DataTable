local SRoleSummonCreate = require("localprotocols.def.action.srolesummoncreate")

function SRoleSummonCreate:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SRoleSummonCreate Process")
  end
  controller:OnSRoleSummonCreate(self)
end

return SRoleSummonCreate
