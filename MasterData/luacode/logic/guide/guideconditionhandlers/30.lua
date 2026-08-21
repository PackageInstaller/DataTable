-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/30.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local tag = tonumber(params[1])
  local state = tonumber(params[2])
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  if tag == -1 then
    if (controller._baseMainFSM):GetLastState() ~= (DataCommon.BaseMainFSM)[state] then
      do return not controller or not controller._baseMainFSM end
      if (controller._baseMainFSM):GetCurrentState() ~= (DataCommon.BaseMainFSM)[state] then
        do return tag ~= 0 end
        do return false end
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
      end
    end
  end
end

return func

