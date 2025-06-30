-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/29.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CEventConfig = (BeanManager.GetTableByName)("event.ceventconfig")
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV, CEventConfig
  local params = conditionInfo.parm
  local dungeonEventID = tonumber(params[1])
  local record = CEventConfig:GetRecorder(dungeonEventID)
  do return not (EventManager.IsFinishedByEventID)(dungeonEventID) or ((NekoData.BehaviorManager).BM_Dungeon):GetCurrentFloorId() == tonumber(record.scene) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return func

