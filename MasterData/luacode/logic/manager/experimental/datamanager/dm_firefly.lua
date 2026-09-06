local CCollectorlvupCfg = BeanManager.GetTableByName("courtyard.ccollectorlvup")
local CTreeLvUpCfg = BeanManager.GetTableByName("courtyard.ctreelvup")
local Item = require("logic.manager.experimental.types.item")
local DM_Firefly = class("DM_Firefly")

function DM_Firefly:Ctor()
  self._firefly = NekoData.Data.firefly
  self._firefly.level = 0
  self._firefly.collectLightsLeftTime = 0
  self._firefly.sceneLights = {}
  self._firefly.makeLightsLeftTime = 0
  self._firefly.fireflyLevel = 0
  self._firefly.collectSpeed = 0
  self._firefly.collectors = {}
  self._firefly._workingFireflyNum = 0
  self._firefly._workState = 0
  self._firefly._pauseNum = 0
  self._collectorlvupRecorders = {}
  local allIds = CCollectorlvupCfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CCollectorlvupCfg:GetRecorder(allIds[i])
    self._collectorlvupRecorders[recorder.id] = recorder
  end
  self._firefly.copywritingPlots = {}
  self._timeCheck = 1
  self._timeCount = 0
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function DM_Firefly:Clear()
  self._firefly.level = 0
  self._firefly.collectLightsLeftTime = 0
  for k, v in pairs(self._firefly.sceneLights) do
    self._firefly.sceneLights[k] = nil
  end
  self._firefly.makeLightsLeftTime = 0
  self._firefly.fireflyLevel = 0
  for k, v in pairs(self._firefly.collectors) do
    self._firefly.collectors[k] = nil
  end
  self._firefly._workingFireflyNum = 0
  self._firefly._workState = 0
  self._firefly._pauseNum = 0
  self._firefly.copywritingPlots = {}
end

function DM_Firefly:OnSYardInfo(protocol)
  self._firefly.level = 0
  self._firefly.collectLightsLeftTime = 0
  for k, v in pairs(self._firefly.sceneLights) do
    self._firefly.sceneLights[k] = nil
  end
  self._firefly.makeLightsLeftTime = 0
  self._firefly.fireflyLevel = 0
  for k, v in pairs(self._firefly.collectors) do
    self._firefly.collectors[k] = nil
  end
  self._firefly._workingFireflyNum = 0
  local lampStandInfo = protocol.lampStand
  self._firefly.level = lampStandInfo.level
  self._firefly.collectLightsLeftTime = lampStandInfo.leftRefreshTime
  LogInfoFormat("DM_Firefly", "--OnSYardInfo-- collectLightsLeftTime = %s", self._firefly.collectLightsLeftTime)
  self._firefly.makeLightsLeftTime = lampStandInfo.leftRefreshLightSpotTime
  self._firefly.fireflyLevel = lampStandInfo.glowwormLevel
  self._firefly.collectSpeed = lampStandInfo.speed
  for i, v in ipairs(lampStandInfo.LightSpots) do
    self._firefly.sceneLights[v.key] = v.itemId
  end
  for k, v in pairs(lampStandInfo.lampTask) do
    local task = {}
    task.collectorId = v.id
    local allIds = CTreeLvUpCfg:GetAllIds()
    local record = CTreeLvUpCfg:GetRecorder(allIds[#allIds])
    if task.collectorId == 1 then
      task.currencyId = DataCommon.WhiteLight
      task.maxLevel = record.light1Lv
    elseif task.collectorId == 2 then
      task.currencyId = DataCommon.DarkLight
      task.maxLevel = record.light2Lv
    elseif task.collectorId == 3 then
      task.currencyId = DataCommon.ColorLight
      task.maxLevel = record.light3Lv
    end
    task.collectorLv = v.level
    task.collectorTaskId = 0
    for k, v in pairs(self._collectorlvupRecorders) do
      if v.type == task.collectorId and v.level == task.collectorLv then
        task.collectorTaskId = v.id
        break
      end
    end
    task.fireflyNum = v.glowwormNums
    self._firefly._workingFireflyNum = self._firefly._workingFireflyNum + task.fireflyNum
    self._firefly.collectors[task.collectorId] = task
  end
  self._bm_Currency = NekoData.BehaviorManager.BM_Currency
end

function DM_Firefly:OnSRefreshLampStand(protocol)
  self:OnSYardInfo(protocol)
end

function DM_Firefly:OnSStrengthTask(protocol)
  for i, v in ipairs(protocol.tasks) do
    local collectorInfo = self._firefly.collectors[v.taskId]
    if collectorInfo then
      collectorInfo.collectorLv = v.taskLevel
      collectorInfo.collectorTaskId = 0
      for k, v in pairs(self._collectorlvupRecorders) do
        if v.type == collectorInfo.collectorId and v.level == collectorInfo.collectorLv then
          collectorInfo.collectorTaskId = v.id
          break
        end
      end
    end
  end
end

function DM_Firefly:OnSGlowwormCapacityLv(protocol)
  self._firefly.fireflyLevel = protocol.glowwormLevel
end

function DM_Firefly:OnSAddGlowworm(protocol)
  local collectorInfo = self._firefly.collectors[protocol.taskId]
  if collectorInfo then
    self._firefly._workingFireflyNum = self._firefly._workingFireflyNum - collectorInfo.fireflyNum + protocol.glowwormTotalNums
    collectorInfo.fireflyNum = protocol.glowwormTotalNums
  end
end

function DM_Firefly:OnSRandomLightSpot(protocol)
  if protocol.light.key ~= -1 then
    self._firefly.sceneLights[protocol.light.key] = protocol.light.itemId
  end
  self._firefly.makeLightsLeftTime = protocol.leftNextRandomLightSpotTime
end

function DM_Firefly:OnSCollectLightSpot(protocol)
  self._firefly.sceneLights[protocol.light.key] = nil
end

function DM_Firefly:OnUpdate(notification)
  if self._firefly.level == 0 then
    return
  end
  self._timeCount = self._timeCount + notification.userInfo.unscaledDeltaTime
  if self._timeCount < self._timeCheck then
    return
  end
  local check = self._timeCheck
  if notification.userInfo.unscaledDeltaTime > self._timeCheck then
    check = math.ceil(self._timeCount)
  end
  self._timeCount = self._timeCount - check
  local count = 0
  local num = 0
  local pauseTaskNum = 0
  local allCollectorsIsMaxLevelAndNum = 0
  for i, task in ipairs(self._firefly.collectors) do
    if 0 < task.collectorTaskId then
      count = count + 1
      local recorder = self._collectorlvupRecorders[task.collectorTaskId]
      local currencyNum = self._bm_Currency:GetCurrencyNum(task.currencyId)
      if 0 < task.fireflyNum and currencyNum < recorder.lightMaxNum then
        num = num + 1
      elseif currencyNum >= recorder.lightMaxNum then
        pauseTaskNum = pauseTaskNum + 1
      end
      if task.collectorLv == task.maxLevel and currencyNum >= recorder.lightMaxNum then
        allCollectorsIsMaxLevelAndNum = allCollectorsIsMaxLevelAndNum + 1
      end
    end
  end
  if 0 < count and count == pauseTaskNum and allCollectorsIsMaxLevelAndNum ~= count then
    num = -1
    pauseTaskNum = 1
  else
    pauseTaskNum = 0
  end
  if 0 < self._firefly.collectLightsLeftTime then
    self._firefly.collectLightsLeftTime = self._firefly.collectLightsLeftTime - check * 1000
    if 0 >= self._firefly.collectLightsLeftTime then
      local ccollectLampStand = LuaNetManager.CreateProtocol("protocol.yard.ccollectlampstand")
      ccollectLampStand:Send()
    end
  end
  if 0 < self._firefly.makeLightsLeftTime then
    self._firefly.makeLightsLeftTime = self._firefly.makeLightsLeftTime - check * 1000
    if 0 >= self._firefly.makeLightsLeftTime then
      local crandomLightSpot = LuaNetManager.CreateProtocol("protocol.yard.crandomlightspot")
      crandomLightSpot:Send()
    end
  end
  if self._firefly._pauseNum ~= pauseTaskNum then
    self._firefly._pauseNum = pauseTaskNum
    LuaNotificationCenter.PostNotification(Common.n_BuildingPauseTaskNumChanged, nil, {
      buildingId = DataCommon.Firefly,
      pauseTaskNum = self._firefly._pauseNum
    })
  end
  if self._firefly._workState ~= num then
    self._firefly._workState = num
    LuaNotificationCenter.PostNotification(Common.n_BuildingWorkStateChanged, nil, {
      buildingId = DataCommon.Firefly,
      state = self._firefly._workState
    })
  end
end

return DM_Firefly
