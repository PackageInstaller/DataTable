-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/17.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local tag1 = ((NekoData.BehaviorManager).BM_SBattleEnd):GetFailTimes() == tonumber(params[1])
  local battleResult = ((NekoData.BehaviorManager).BM_Game):GetBattleResult()
  local tag2 = not battleResult or battleResult.failTime == tonumber(params[1]) or battleResult.battleId == tonumber(params[2])
  do return tag1 or tag2 end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

return func

