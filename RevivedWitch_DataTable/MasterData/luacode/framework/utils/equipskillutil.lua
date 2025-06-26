-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/utils/equipskillutil.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EquipSkillUtil = {}
EquipSkillUtil.HasEquipSkill = function(id)
  -- function num : 0_0 , upvalues : _ENV
  local behaviourManager = NekoData.BehaviorManager
  local currentRoleKeys = ((NekoData.BehaviorManager).BM_Team):GetCurrentRoleKeys()
  for k,v in pairs(currentRoleKeys) do
    if v > 0 then
      local role = (behaviourManager.BM_AllRoles):GetRole(v)
      local suitSkillsMap = role:GetSuitSkillsMap()
      for suitid,skills in pairs(suitSkillsMap) do
        for i,skillid in ipairs(skills.skillIds) do
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

