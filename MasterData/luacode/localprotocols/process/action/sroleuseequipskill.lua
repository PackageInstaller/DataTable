local SRoleUseEquipSkill = require("localprotocols.def.action.sroleuseequipskill")

function SRoleUseEquipSkill:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SRoleUseEquipSkill Process")
  end
  if controller.OnSRoleUseEquipSkill then
    controller:OnSRoleUseEquipSkill(self)
  end
end

return SRoleUseEquipSkill
