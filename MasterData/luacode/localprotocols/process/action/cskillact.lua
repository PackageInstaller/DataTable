local CSkillAct = require("localprotocols.def.action.cskillact")

function CSkillAct:Process(battleWorld)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CSkillAct Process")
  end
  battleWorld:OnCSkillAct(self)
end

return CSkillAct
