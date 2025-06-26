-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/6.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cstairvarcfg = (BeanManager.GetTableByName)("dungeonselect.cstairvarcfg")
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV, cstairvarcfg
  do return ((NekoData.BehaviorManager).BM_TowerV2):GetCurrentFloorID() == tonumber((cstairvarcfg:GetRecorder(10)).value) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return func

