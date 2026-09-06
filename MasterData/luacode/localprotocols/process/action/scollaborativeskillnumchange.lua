local SCollaborativeSkillNumChange = require("localprotocols.def.action.scollaborativeskillnumchange")

function SCollaborativeSkillNumChange:Process(controller)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SCollaborativeSkillNumChange Process")
  end
  if controller.OnSCollaborativeSkillNumChange then
    controller:OnSCollaborativeSkillNumChange(self)
  end
end

return SCollaborativeSkillNumChange
