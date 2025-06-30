-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/20.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local bannerId = params[1]
  local status = tonumber(params[2]) == 1
  do
    if bannerId then
      local open = ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(tonumber(params[1]))
      return open == status
    end
    do return false end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

return func

