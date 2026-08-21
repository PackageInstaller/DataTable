-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/31.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local tag = tonumber(params[1])
  local state = tonumber(params[2])
  if tag == -1 then
    if GlobalGameFSM:GetLastState() ~= (DataCommon.GameFSM)[state] then
      do return not GlobalGameFSM end
      if GlobalGameFSM:GetCurrentState() ~= (DataCommon.GameFSM)[state] then
        do return tag ~= 0 end
        do return false end
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
      end
    end
  end
end

return func

