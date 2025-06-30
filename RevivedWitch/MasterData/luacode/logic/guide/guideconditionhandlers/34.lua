-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/34.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local sceneId = tonumber(params[1])
  local curId = ((NekoData.BehaviorManager).BM_Dungeon):GetCurrentFloorId()
  do return not curId or curId == sceneId end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return func

