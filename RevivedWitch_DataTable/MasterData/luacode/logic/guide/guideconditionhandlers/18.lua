-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/18.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(21) then
    local params = conditionInfo.parm
    local taskId = tonumber(params[1])
    local isFinished = tonumber(params[2]) == 1
    local taskData = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityManagerID)):GetMissions()
    for i,v in ipairs(taskData) do
      if v.ID == taskId then
        if isFinished and v.isFinish == 1 then
          return true
        end
        return false
      end
    end
  end
  do return false end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

return func

