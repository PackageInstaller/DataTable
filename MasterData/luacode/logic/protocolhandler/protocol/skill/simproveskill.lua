local CSkillMapTable = BeanManager.GetTableByName("skill.cskillmap")
local CSkillItemTable = BeanManager.GetTableByName("item.cskillitem")

local function p1(protocol)
  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCity" or GlobalGameFSM:GetCurrentState() == "SwimSuitActivity" or DialogManager.GetDialog("battle.battleaccount.battlelosetextdialog") then
    local skillId, skillItemId
    local nodeRecord = CSkillMapTable:GetRecorder(protocol.unlockNode)
    if nodeRecord then
      if NekoData.BehaviorManager.BM_Game:IsSkillItemId(nodeRecord.skillID) then
        local skillItemRecord = CSkillItemTable:GetRecorder(nodeRecord.skillID)
        skillId = skillItemRecord.skillID[nodeRecord.skillLevel]
        skillItemId = nodeRecord.skillID
      else
        skillId = nodeRecord.skillID
      end
    else
      LogErrorFormat("SImproveSkill", "no id %s in cskillmap", protocol.unlockNode)
    end
    DialogManager.CreateSingletonDialog("skill.skillunlocksuccessdialog"):SetData(skillId, skillItemId, protocol.roleId)
    LuaNotificationCenter.PostNotification(Common.n_ImproveSkill, nil, protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
