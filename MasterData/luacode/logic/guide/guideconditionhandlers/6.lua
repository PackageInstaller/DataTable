local cstairvarcfg = BeanManager.GetTableByName("dungeonselect.cstairvarcfg")

local function func(conditionInfo)
  return NekoData.BehaviorManager.BM_TowerV2:GetCurrentFloorID() == tonumber(cstairvarcfg:GetRecorder(10).value)
end

return func
