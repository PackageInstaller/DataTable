local DM_CopyBase = require("logic.manager.experimental.datamanager.dm_copybase")
local CStarrymirrorlevel = BeanManager.GetTableByName("dungeonselect.cstarrymirrorlevel")
local CStarrymirrorfuncunlock = BeanManager.GetTableByName("dungeonselect.cstarrymirrorfuncunlock")
local DM_StarMirageCopy = class("DM_StarMirageCopy", DM_CopyBase)

function DM_StarMirageCopy:Ctor(...)
  self._data = NekoData.Data.starMirageCopy
  self._data.baseData = {}
  local other = {
    LevelCfg = CStarrymirrorlevel,
    FunctionUnlockCfg = CStarrymirrorfuncunlock,
    Type = DataCommon.StarMirage1[DataCommon.Activities.StarMirageCopy].Type,
    Function = DataCommon.StarMirage1[DataCommon.Activities.StarMirageCopy].Function
  }
  DM_StarMirageCopy.super.Ctor(self, self._data.baseData, other)
  self._data.dailySupplyData = nil
  self._data.accumulateRewardList = {}
  self._data.accumulatePoints = {}
end

function DM_StarMirageCopy:Clear()
  DM_StarMirageCopy.super.Clear(self)
  self._data.dailySupplyData = nil
  while self._data.accumulateRewardList[#self._data.accumulateRewardList] do
    table.remove(self._data.accumulateRewardList, #self._data.accumulateRewardList)
  end
  for k, v in pairs(self._data.accumulatePoints) do
    self._data.accumulatePoints[k] = nil
  end
end

function DM_StarMirageCopy:OnSActivityDailySupply(protocol)
  self._data.dailySupplyData = protocol.supply
end

function DM_StarMirageCopy:OnSGetPointsCollection(protocol)
  while self._data.accumulateRewardList[#self._data.accumulateRewardList] do
    table.remove(self._data.accumulateRewardList, #self._data.accumulateRewardList)
  end
  for i, v in ipairs(protocol.tasks) do
    LogInfoFormat("DM_StarMirageCopy", "-OnSGetPointsCollection- stageId = %s, status = %s ---", v.id, v.status)
    local data = {}
    data.stageId = v.id
    data.status = v.status
    table.insert(self._data.accumulateRewardList, data)
  end
  for k, v in pairs(protocol.points) do
    self._data.accumulatePoints[k] = v
    LogInfoFormat("DM_StarMirageCopy", "-OnSGetPointsCollection- itemId = %s, num = %s ---", k, v)
  end
end

function DM_StarMirageCopy:OnSRefreshPointsTasks(protocol)
  for i, v in ipairs(protocol.tasks) do
    LogInfoFormat("DM_StarMirageCopy", "-OnSRefreshPointsTasks- stageId = %s, status = %s ---", v.id, v.status)
    for _, data in ipairs(self._data.accumulateRewardList) do
      if v.id == data.stageId then
        data.status = v.status
      end
    end
  end
end

return DM_StarMirageCopy
