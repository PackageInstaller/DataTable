local EquipSkillUtil = {}

function EquipSkillUtil.HasEquipSkill(id)
  local behaviourManager = NekoData.BehaviorManager
  local currentRoleKeys = NekoData.BehaviorManager.BM_Team:GetCurrentRoleKeys()
  for k, v in pairs(currentRoleKeys) do
    if 0 < v then
      local role = behaviourManager.BM_AllRoles:GetRole(v)
      local suitSkillsMap = role:GetSuitSkillsMap()
      for suitid, skills in pairs(suitSkillsMap) do
        for i, skillid in ipairs(skills.skillIds) do
          if skillid == id then
            return true
          end
        end
      end
    end
  end
  return false
end

return EquipSkillUtil
