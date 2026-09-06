local CSkillMapTable = BeanManager.GetTableByName("skill.cskillmap")

local function func(nodeId, params)
  return CSkillMapTable:GetRecorder(nodeId)
end

return func
