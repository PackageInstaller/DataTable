-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/42.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  do return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):GetLastBattleResult() == tonumber(params[1]) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return func

