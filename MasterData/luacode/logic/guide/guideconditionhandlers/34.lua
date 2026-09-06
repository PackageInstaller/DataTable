local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local sceneId = tonumber(params[1])
  local curId = NekoData.BehaviorManager.BM_Dungeon:GetCurrentFloorId()
  return curId and curId == sceneId
end

return func
