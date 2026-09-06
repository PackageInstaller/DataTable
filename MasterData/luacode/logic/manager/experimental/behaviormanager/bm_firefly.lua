local CCollectorlvupCfg = BeanManager.GetTableByName("courtyard.ccollectorlvup")
local CLampstandlvupCfg = BeanManager.GetTableByName("courtyard.clampstandlvup")
local CTreeLvUpCfg = BeanManager.GetTableByName("courtyard.ctreelvup")
local CFireflylvupCfg = BeanManager.GetTableByName("courtyard.cfireflylvup")
local CFireflyLitTxtCfg = BeanManager.GetTableByName("courtyard.cfireflylittxt")
local BM_Firefly = class("BM_Firefly")

function BM_Firefly:Ctor()
  self._firefly = NekoData.Data.firefly
end

function BM_Firefly:GetCollectorsInfo()
  return self._firefly.collectors
end

function BM_Firefly:GetLevel()
  return self._firefly.level
end

function BM_Firefly:GetCurMaxLevelByCollectorId(id)
  local level = 0
  local magicTreeLv = NekoData.BehaviorManager.BM_MagicTree:GetLevel()
  if 0 < magicTreeLv then
    local record = CTreeLvUpCfg:GetRecorder(magicTreeLv)
    if record then
      if id == 1 then
        return record.light1Lv
      elseif id == 2 then
        return record.light2Lv
      elseif id == 3 then
        return record.light3Lv
      end
    end
  end
  return level
end

function BM_Firefly:GetMaxLevelByCollectorId(id)
  local level = 0
  local magicTreeLv = NekoData.BehaviorManager.BM_MagicTree:GetLevel()
  if 0 < magicTreeLv then
    local allIds = CTreeLvUpCfg:GetAllIds()
    local record = CTreeLvUpCfg:GetRecorder(allIds[#allIds])
    if record then
      if id == 1 then
        return record.light1Lv
      elseif id == 2 then
        return record.light2Lv
      elseif id == 3 then
        return record.light3Lv
      end
    end
  end
  return level
end

function BM_Firefly:GetDispatchRoles()
  local list = {}
  return list
end

function BM_Firefly:GetDispatchMaxRoleNum()
  return 0
end

function BM_Firefly:GetGetNum()
  return 0
end

function BM_Firefly:GetWorkState()
  return self._firefly._workState
end

function BM_Firefly:GetPauseTaskNum()
  return self._firefly._pauseNum
end

function BM_Firefly:GetSceneLights()
  local map = {}
  for k, v in pairs(self._firefly.sceneLights) do
    map[k] = v
  end
  return map
end

function BM_Firefly:GetCollectLightsLeftTime()
  return self._firefly.collectLightsLeftTime
end

function BM_Firefly:GetCollectLightsRate()
  if self._firefly.level > 0 then
    local record = CLampstandlvupCfg:GetRecorder(self._firefly.level)
    if record then
      return record.getRate * 60 * 1000
    end
  end
  return 0
end

function BM_Firefly:GetLightMaxCapacity(currencyId)
  local collectorId
  if currencyId == DataCommon.WhiteLight then
    collectorId = 1
  elseif currencyId == DataCommon.DarkLight then
    collectorId = 2
  elseif currencyId == DataCommon.ColorLight then
    collectorId = 3
  end
  if collectorId then
    local collectorInfo = self._firefly.collectors[collectorId]
    if collectorInfo and collectorInfo.collectorTaskId ~= 0 then
      local recorder = CCollectorlvupCfg:GetRecorder(collectorInfo.collectorTaskId)
      if recorder then
        return recorder.lightMaxNum
      end
    end
  end
  return 0
end

function BM_Firefly:GetFireflyLevel()
  return self._firefly.fireflyLevel
end

function BM_Firefly:GetFireflyCurMaxLv()
  if self._firefly.level > 0 then
    local record = CLampstandlvupCfg:GetRecorder(self._firefly.level)
    if record then
      return record.fireflyMaxLv
    end
  end
  return 0
end

function BM_Firefly:GetFireflyMaxLv()
  if self._firefly.level > 0 then
    local allIds = CLampstandlvupCfg:GetAllIds()
    local record = CLampstandlvupCfg:GetRecorder(allIds[#allIds])
    if record then
      return record.fireflyMaxLv
    end
  end
  return 0
end

function BM_Firefly:GetFreeFireflyNum()
  local record = CFireflylvupCfg:GetRecorder(self._firefly.fireflyLevel)
  if record then
    return record.num - self._firefly._workingFireflyNum
  else
    return 0
  end
end

function BM_Firefly:GetMaxFireflyNum()
  local record = CFireflylvupCfg:GetRecorder(self._firefly.fireflyLevel)
  if record then
    return record.num
  else
    return 0
  end
end

function BM_Firefly:GetCollectorInfoById(collectorId)
  return self._firefly.collectors[collectorId]
end

function BM_Firefly:GetCollectSpeed()
  return self._firefly.collectSpeed
end

function BM_Firefly:GetCopywritingPlotId()
  if #self._firefly.copywritingPlots == 0 then
    local record = CFireflyLitTxtCfg:GetRecorder(1)
    for _, v in ipairs(record.fireflyscenarios) do
      table.insert(self._firefly.copywritingPlots, v)
    end
  end
  local id = self._firefly.copywritingPlots[1]
  table.remove(self._firefly.copywritingPlots, 1)
  return id
end

return BM_Firefly
