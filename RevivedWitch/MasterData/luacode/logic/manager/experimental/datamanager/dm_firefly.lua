-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_firefly.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCollectorlvupCfg = (BeanManager.GetTableByName)("courtyard.ccollectorlvup")
local CTreeLvUpCfg = (BeanManager.GetTableByName)("courtyard.ctreelvup")
local Item = require("logic.manager.experimental.types.item")
local DM_Firefly = class("DM_Firefly")
DM_Firefly.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, CCollectorlvupCfg
  self._firefly = (NekoData.Data).firefly
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly).level = 0
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly).collectLightsLeftTime = 0
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly).sceneLights = {}
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly).makeLightsLeftTime = 0
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly).fireflyLevel = 0
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly).collectSpeed = 0
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly).collectors = {}
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly)._workingFireflyNum = 0
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly)._workState = 0
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly)._pauseNum = 0
  self._collectorlvupRecorders = {}
  local allIds = CCollectorlvupCfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CCollectorlvupCfg:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._collectorlvupRecorders)[recorder.id] = recorder
  end
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._firefly).copywritingPlots = {}
  self._timeCheck = 1
  self._timeCount = 0
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

DM_Firefly.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._firefly).level = 0
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly).collectLightsLeftTime = 0
  for k,v in pairs((self._firefly).sceneLights) do
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R6 in 'UnsetPending'

    ((self._firefly).sceneLights)[k] = nil
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly).makeLightsLeftTime = 0
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly).fireflyLevel = 0
  for k,v in pairs((self._firefly).collectors) do
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

    ((self._firefly).collectors)[k] = nil
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly)._workingFireflyNum = 0
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly)._workState = 0
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly)._pauseNum = 0
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._firefly).copywritingPlots = {}
end

DM_Firefly.OnSYardInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV, CTreeLvUpCfg
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._firefly).level = 0
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._firefly).collectLightsLeftTime = 0
  for k,v in pairs((self._firefly).sceneLights) do
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R7 in 'UnsetPending'

    ((self._firefly).sceneLights)[k] = nil
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._firefly).makeLightsLeftTime = 0
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._firefly).fireflyLevel = 0
  for k,v in pairs((self._firefly).collectors) do
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

    ((self._firefly).collectors)[k] = nil
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._firefly)._workingFireflyNum = 0
  local lampStandInfo = protocol.lampStand
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._firefly).level = lampStandInfo.level
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._firefly).collectLightsLeftTime = lampStandInfo.leftRefreshTime
  LogInfoFormat("DM_Firefly", "--OnSYardInfo-- collectLightsLeftTime = %s", (self._firefly).collectLightsLeftTime)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._firefly).makeLightsLeftTime = lampStandInfo.leftRefreshLightSpotTime
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._firefly).fireflyLevel = lampStandInfo.glowwormLevel
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._firefly).collectSpeed = lampStandInfo.speed
  for i,v in ipairs(lampStandInfo.LightSpots) do
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R8 in 'UnsetPending'

    ((self._firefly).sceneLights)[v.key] = v.itemId
  end
  for k,v in pairs(lampStandInfo.lampTask) do
    local task = {}
    task.collectorId = v.id
    local allIds = CTreeLvUpCfg:GetAllIds()
    local record = CTreeLvUpCfg:GetRecorder(allIds[#allIds])
    if task.collectorId == 1 then
      task.currencyId = DataCommon.WhiteLight
      task.maxLevel = record.light1Lv
    else
      if task.collectorId == 2 then
        task.currencyId = DataCommon.DarkLight
        task.maxLevel = record.light2Lv
      else
        if task.collectorId == 3 then
          task.currencyId = DataCommon.ColorLight
          task.maxLevel = record.light3Lv
        end
      end
    end
    task.collectorLv = v.level
    task.collectorTaskId = 0
    for k,v in pairs(self._collectorlvupRecorders) do
      if v.type == task.collectorId and v.level == task.collectorLv then
        task.collectorTaskId = v.id
        break
      end
    end
    do
      do
        task.fireflyNum = v.glowwormNums
        -- DECOMPILER ERROR at PC131: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self._firefly)._workingFireflyNum = (self._firefly)._workingFireflyNum + task.fireflyNum
        -- DECOMPILER ERROR at PC135: Confused about usage of register: R11 in 'UnsetPending'

        ;
        ((self._firefly).collectors)[task.collectorId] = task
        -- DECOMPILER ERROR at PC136: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  self._bm_Currency = (NekoData.BehaviorManager).BM_Currency
end

DM_Firefly.OnSRefreshLampStand = function(self, protocol)
  -- function num : 0_3
  self:OnSYardInfo(protocol)
end

DM_Firefly.OnSStrengthTask = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  for i,v in ipairs(protocol.tasks) do
    local collectorInfo = ((self._firefly).collectors)[v.taskId]
    if collectorInfo then
      collectorInfo.collectorLv = v.taskLevel
      collectorInfo.collectorTaskId = 0
      for k,v in pairs(self._collectorlvupRecorders) do
        if v.type == collectorInfo.collectorId and v.level == collectorInfo.collectorLv then
          collectorInfo.collectorTaskId = v.id
          break
        end
      end
    end
  end
end

DM_Firefly.OnSGlowwormCapacityLv = function(self, protocol)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._firefly).fireflyLevel = protocol.glowwormLevel
end

DM_Firefly.OnSAddGlowworm = function(self, protocol)
  -- function num : 0_6
  local collectorInfo = ((self._firefly).collectors)[protocol.taskId]
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  if collectorInfo then
    (self._firefly)._workingFireflyNum = (self._firefly)._workingFireflyNum - collectorInfo.fireflyNum + protocol.glowwormTotalNums
    collectorInfo.fireflyNum = protocol.glowwormTotalNums
  end
end

DM_Firefly.OnSRandomLightSpot = function(self, protocol)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if (protocol.light).key ~= -1 then
    ((self._firefly).sceneLights)[(protocol.light).key] = (protocol.light).itemId
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._firefly).makeLightsLeftTime = protocol.leftNextRandomLightSpotTime
end

DM_Firefly.OnSCollectLightSpot = function(self, protocol)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self._firefly).sceneLights)[(protocol.light).key] = nil
end

DM_Firefly.OnUpdate = function(self, notification)
  -- function num : 0_9 , upvalues : _ENV
  if (self._firefly).level == 0 then
    return 
  end
  self._timeCount = self._timeCount + (notification.userInfo).unscaledDeltaTime
  if self._timeCount < self._timeCheck then
    return 
  end
  local check = self._timeCheck
  if self._timeCheck < (notification.userInfo).unscaledDeltaTime then
    check = (math.ceil)(self._timeCount)
  end
  self._timeCount = self._timeCount - check
  local count = 0
  local num = 0
  local pauseTaskNum = 0
  local allCollectorsIsMaxLevelAndNum = 0
  for i,task in ipairs((self._firefly).collectors) do
    if task.collectorTaskId > 0 then
      count = count + 1
      local recorder = (self._collectorlvupRecorders)[task.collectorTaskId]
      local currencyNum = (self._bm_Currency):GetCurrencyNum(task.currencyId)
      if task.fireflyNum > 0 and currencyNum < recorder.lightMaxNum then
        num = num + 1
      else
        if recorder.lightMaxNum <= currencyNum then
          pauseTaskNum = pauseTaskNum + 1
        end
      end
      if task.collectorLv == task.maxLevel and recorder.lightMaxNum <= currencyNum then
        allCollectorsIsMaxLevelAndNum = allCollectorsIsMaxLevelAndNum + 1
      end
    end
  end
  if count > 0 and count == pauseTaskNum and allCollectorsIsMaxLevelAndNum ~= count then
    num = -1
    pauseTaskNum = 1
  else
    pauseTaskNum = 0
  end
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R7 in 'UnsetPending'

  if (self._firefly).collectLightsLeftTime > 0 then
    (self._firefly).collectLightsLeftTime = (self._firefly).collectLightsLeftTime - check * 1000
    if (self._firefly).collectLightsLeftTime <= 0 then
      local ccollectLampStand = (LuaNetManager.CreateProtocol)("protocol.yard.ccollectlampstand")
      ccollectLampStand:Send()
    end
  end
  do
    -- DECOMPILER ERROR at PC110: Confused about usage of register: R7 in 'UnsetPending'

    if (self._firefly).makeLightsLeftTime > 0 then
      (self._firefly).makeLightsLeftTime = (self._firefly).makeLightsLeftTime - check * 1000
      if (self._firefly).makeLightsLeftTime <= 0 then
        local crandomLightSpot = (LuaNetManager.CreateProtocol)("protocol.yard.crandomlightspot")
        crandomLightSpot:Send()
      end
    end
    do
      -- DECOMPILER ERROR at PC126: Confused about usage of register: R7 in 'UnsetPending'

      if (self._firefly)._pauseNum ~= pauseTaskNum then
        (self._firefly)._pauseNum = pauseTaskNum
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_BuildingPauseTaskNumChanged, nil, {buildingId = DataCommon.Firefly, pauseTaskNum = (self._firefly)._pauseNum})
      end
      -- DECOMPILER ERROR at PC145: Confused about usage of register: R7 in 'UnsetPending'

      if (self._firefly)._workState ~= num then
        (self._firefly)._workState = num
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_BuildingWorkStateChanged, nil, {buildingId = DataCommon.Firefly, state = (self._firefly)._workState})
      end
    end
  end
end

return DM_Firefly

