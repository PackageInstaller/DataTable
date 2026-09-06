local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local buildingId = tonumber(params[1])
  local op = tonumber(params[2])
  local lv = tonumber(params[3])
  local bm_building
  if buildingId == DataCommon.Cabin then
    bm_building = NekoData.BehaviorManager.BM_Cabin
  elseif buildingId == DataCommon.Firefly then
    bm_building = NekoData.BehaviorManager.BM_Firefly
  elseif buildingId == DataCommon.Explore then
    bm_building = NekoData.BehaviorManager.BM_Explore
  end
  local buildingLv
  if bm_building then
    buildingLv = bm_building:GetLevel()
  end
  if not buildingLv then
    return false
  else
    if op == -1 then
      return lv > buildingLv
    elseif op == 0 then
      return buildingLv == lv
    elseif op == 1 then
      return lv < buildingLv
    end
    return false
  end
end

return func
