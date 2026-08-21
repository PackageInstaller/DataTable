-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_firefly.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCollectorlvupCfg = (BeanManager.GetTableByName)("courtyard.ccollectorlvup")
local CLampstandlvupCfg = (BeanManager.GetTableByName)("courtyard.clampstandlvup")
local CTreeLvUpCfg = (BeanManager.GetTableByName)("courtyard.ctreelvup")
local CFireflylvupCfg = (BeanManager.GetTableByName)("courtyard.cfireflylvup")
local CFireflyLitTxtCfg = (BeanManager.GetTableByName)("courtyard.cfireflylittxt")
local BM_Firefly = class("BM_Firefly")
BM_Firefly.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._firefly = (NekoData.Data).firefly
end

BM_Firefly.GetCollectorsInfo = function(self)
  -- function num : 0_1
  return (self._firefly).collectors
end

BM_Firefly.GetLevel = function(self)
  -- function num : 0_2
  return (self._firefly).level
end

BM_Firefly.GetCurMaxLevelByCollectorId = function(self, id)
  -- function num : 0_3 , upvalues : _ENV, CTreeLvUpCfg
  local level = 0
  local magicTreeLv = ((NekoData.BehaviorManager).BM_MagicTree):GetLevel()
  do
    if magicTreeLv > 0 then
      local record = CTreeLvUpCfg:GetRecorder(magicTreeLv)
      if record then
        if id == 1 then
          return record.light1Lv
        else
          if id == 2 then
            return record.light2Lv
          else
            if id == 3 then
              return record.light3Lv
            end
          end
        end
      end
    end
    return level
  end
end

BM_Firefly.GetMaxLevelByCollectorId = function(self, id)
  -- function num : 0_4 , upvalues : _ENV, CTreeLvUpCfg
  local level = 0
  local magicTreeLv = ((NekoData.BehaviorManager).BM_MagicTree):GetLevel()
  if magicTreeLv > 0 then
    local allIds = CTreeLvUpCfg:GetAllIds()
    local record = CTreeLvUpCfg:GetRecorder(allIds[#allIds])
    if record then
      if id == 1 then
        return record.light1Lv
      else
        if id == 2 then
          return record.light2Lv
        else
          if id == 3 then
            return record.light3Lv
          end
        end
      end
    end
  end
  do
    return level
  end
end

BM_Firefly.GetDispatchRoles = function(self)
  -- function num : 0_5
  local list = {}
  return list
end

BM_Firefly.GetDispatchMaxRoleNum = function(self)
  -- function num : 0_6
  return 0
end

BM_Firefly.GetGetNum = function(self)
  -- function num : 0_7
  return 0
end

BM_Firefly.GetWorkState = function(self)
  -- function num : 0_8
  return (self._firefly)._workState
end

BM_Firefly.GetPauseTaskNum = function(self)
  -- function num : 0_9
  return (self._firefly)._pauseNum
end

BM_Firefly.GetSceneLights = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local map = {}
  for k,v in pairs((self._firefly).sceneLights) do
    map[k] = v
  end
  return map
end

BM_Firefly.GetCollectLightsLeftTime = function(self)
  -- function num : 0_11
  return (self._firefly).collectLightsLeftTime
end

BM_Firefly.GetCollectLightsRate = function(self)
  -- function num : 0_12 , upvalues : CLampstandlvupCfg
  do
    if (self._firefly).level > 0 then
      local record = CLampstandlvupCfg:GetRecorder((self._firefly).level)
      if record then
        return record.getRate * 60 * 1000
      end
    end
    return 0
  end
end

BM_Firefly.GetLightMaxCapacity = function(self, currencyId)
  -- function num : 0_13 , upvalues : _ENV, CCollectorlvupCfg
  local collectorId = nil
  if currencyId == DataCommon.WhiteLight then
    collectorId = 1
  else
    if currencyId == DataCommon.DarkLight then
      collectorId = 2
    else
      if currencyId == DataCommon.ColorLight then
        collectorId = 3
      end
    end
  end
  if collectorId then
    local collectorInfo = ((self._firefly).collectors)[collectorId]
    if collectorInfo and collectorInfo.collectorTaskId ~= 0 then
      local recorder = CCollectorlvupCfg:GetRecorder(collectorInfo.collectorTaskId)
      if recorder then
        return recorder.lightMaxNum
      end
    end
  end
  do
    return 0
  end
end

BM_Firefly.GetFireflyLevel = function(self)
  -- function num : 0_14
  return (self._firefly).fireflyLevel
end

BM_Firefly.GetFireflyCurMaxLv = function(self)
  -- function num : 0_15 , upvalues : CLampstandlvupCfg
  do
    if (self._firefly).level > 0 then
      local record = CLampstandlvupCfg:GetRecorder((self._firefly).level)
      if record then
        return record.fireflyMaxLv
      end
    end
    return 0
  end
end

BM_Firefly.GetFireflyMaxLv = function(self)
  -- function num : 0_16 , upvalues : CLampstandlvupCfg
  if (self._firefly).level > 0 then
    local allIds = CLampstandlvupCfg:GetAllIds()
    local record = CLampstandlvupCfg:GetRecorder(allIds[#allIds])
    if record then
      return record.fireflyMaxLv
    end
  end
  do
    return 0
  end
end

BM_Firefly.GetFreeFireflyNum = function(self)
  -- function num : 0_17 , upvalues : CFireflylvupCfg
  local record = CFireflylvupCfg:GetRecorder((self._firefly).fireflyLevel)
  if record then
    return record.num - (self._firefly)._workingFireflyNum
  else
    return 0
  end
end

BM_Firefly.GetMaxFireflyNum = function(self)
  -- function num : 0_18 , upvalues : CFireflylvupCfg
  local record = CFireflylvupCfg:GetRecorder((self._firefly).fireflyLevel)
  if record then
    return record.num
  else
    return 0
  end
end

BM_Firefly.GetCollectorInfoById = function(self, collectorId)
  -- function num : 0_19
  return ((self._firefly).collectors)[collectorId]
end

BM_Firefly.GetCollectSpeed = function(self)
  -- function num : 0_20
  return (self._firefly).collectSpeed
end

BM_Firefly.GetCopywritingPlotId = function(self)
  -- function num : 0_21 , upvalues : CFireflyLitTxtCfg, _ENV
  if #(self._firefly).copywritingPlots == 0 then
    local record = CFireflyLitTxtCfg:GetRecorder(1)
    for _,v in ipairs(record.fireflyscenarios) do
      (table.insert)((self._firefly).copywritingPlots, v)
    end
  end
  do
    local id = ((self._firefly).copywritingPlots)[1]
    ;
    (table.remove)((self._firefly).copywritingPlots, 1)
    return id
  end
end

return BM_Firefly

