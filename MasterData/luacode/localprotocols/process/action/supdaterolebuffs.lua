local SUpdateRoleBuffs = require("localprotocols.def.action.supdaterolebuffs")

function SUpdateRoleBuffs:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SUpdateRoleBuffs Process")
  end
  if controller.OnSUpdateRoleBuffs then
    controller:OnSUpdateRoleBuffs(self)
  end
end

return SUpdateRoleBuffs
