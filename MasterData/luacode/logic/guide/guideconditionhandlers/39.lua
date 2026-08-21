-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/39.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local buildingId = tonumber(params[1])
  local op = tonumber(params[2])
  local lv = (tonumber(params[3]))
  local bm_building = nil
  if buildingId == DataCommon.Cabin then
    bm_building = (NekoData.BehaviorManager).BM_Cabin
  else
    if buildingId == DataCommon.Firefly then
      bm_building = (NekoData.BehaviorManager).BM_Firefly
    else
      if buildingId == DataCommon.Explore then
        bm_building = (NekoData.BehaviorManager).BM_Explore
      end
    end
  end
  local buildingLv = nil
  if bm_building then
    buildingLv = bm_building:GetLevel()
  end
  if not buildingLv then
    return false
  else
    if buildingLv >= lv then
      do return op ~= -1 end
      if buildingLv ~= lv then
        do return op ~= 0 end
        if lv >= buildingLv then
          do return op ~= 1 end
          do return false end
          -- DECOMPILER ERROR: 7 unprocessed JMP targets
        end
      end
    end
  end
end

return func

