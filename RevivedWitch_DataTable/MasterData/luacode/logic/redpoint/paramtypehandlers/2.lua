-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/redpoint/paramtypehandlers/2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillMapTable = (BeanManager.GetTableByName)("skill.cskillmap")
local func = function(nodeId, params)
  -- function num : 0_0 , upvalues : CSkillMapTable
  return CSkillMapTable:GetRecorder(nodeId)
end

return func

