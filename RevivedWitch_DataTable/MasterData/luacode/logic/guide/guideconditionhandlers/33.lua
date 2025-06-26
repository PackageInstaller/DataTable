-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/33.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local zoneId = ((NekoData.BehaviorManager).BM_Game):GetNextFloorId()
  do return not zoneId or zoneId == tonumber(params[1]) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return func

