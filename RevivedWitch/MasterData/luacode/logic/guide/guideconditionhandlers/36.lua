-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/36.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local tagId = tonumber(params[1])
  local tagValue = tonumber(params[2])
  local value = ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(tagId)
  do return not value or value == tagValue end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return func

