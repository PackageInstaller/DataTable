local LevelStateEnum = LuaNetManager.GetBeanDef("protocol.battle.activitybattlenode")
local DM_StarMirage = class("DM_StarMirage")

function DM_StarMirage:Ctor()
  self._data = NekoData.Data.activities.starmirage
  self._data.levelMap = {}
  self._data.accumulateRewardList = {}
  self._data.accumulatePoints = {}
  self._data.nextTypePeriod = nil
end

function DM_StarMirage:Clear()
  for k, v in pairs(self._data.levelMap) do
    self._data.levelMap[k] = nil
  end
  for k, v in pairs(self._data.accumulatePoints) do
    self._data.accumulatePoints[k] = nil
  end
  while self._data.accumulateRewardList[#self._data.accumulateRewardList] do
    table.remove(self._data.accumulateRewardList, #self._data.accumulateRewardList)
  end
  self._data.nextTypePeriod = nil
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
end

local function AddGameTimer(self)
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
  if self._data.nextTypePeriod > 0 then
    self._gameTimerID = GameTimer.AddTask(math.ceil(self._data.nextTypePeriod / 1000), 0, function()
      local protocol = LuaNetManager.CreateProtocol("protocol.battle.cgetactivitybattlelist")
      protocol.activityId = DataCommon.Activities.StarMirage
      protocol:Send()
    end)
  end
end

function DM_StarMirage:OnSGetActivityBattleList(protocol)
  self._data.nextTypePeriod = protocol.time2NextPeriod
  AddGameTimer(self)
  for k, v in pairs(self._data.levelMap) do
    self._data.levelMap[k] = nil
  end
  for i, v in ipairs(protocol.battleNodes) do
    LogInfoFormat("DM_StarMirage", "-OnSGetActivityBattleList- levelId = %s, status = %s, bossLevel = %s, first = %s ---", v.id, v.status, v.bossLevel, v.first)
    local data = {}
    data.levelId = v.id
    data.status = v.status
    data.recommendLevel = v.level
    data.costSpirit = v.spirit
    data.firstGet = v.first == 1
    data.firstItems = v.firstItems
    data.randItems = v.randItems
    data.normalItems = v.normalItems
    data.bossLevel = v.bossLevel
    if not self._data.levelMap[v.battletype] then
      self._data.levelMap[v.battletype] = {}
    end
    table.insert(self._data.levelMap[v.battletype], data)
  end
end

local function GetDataById(self, battletype, levelId)
  local list = self._data.levelMap[battletype]
  if list then
    for i, v in ipairs(list) do
      if v.levelId == levelId then
        return i
      end
    end
  end
end

function DM_StarMirage:OnSUpdateActivityBattleList(protocol)
  for i, v in ipairs(protocol.battleNodes) do
    LogInfoFormat("DM_StarMirage", "-OnSUpdateActivityBattleList- levelId = %s, status = %s, bossLevel = %s, first = %s ---", v.id, v.status, v.bossLevel, v.first)
    local index = GetDataById(self, v.battletype, v.id)
    local data = {}
    data.levelId = v.id
    data.status = v.status
    data.recommendLevel = v.level
    data.costSpirit = v.spirit
    data.firstGet = v.first == 1
    data.firstItems = v.firstItems
    data.randItems = v.randItems
    data.normalItems = v.normalItems
    data.bossLevel = v.bossLevel
    if index then
      self._data.levelMap[v.battletype][index] = data
    else
      if not self._data.levelMap[v.battletype] then
        self._data.levelMap[v.battletype] = {}
      end
      table.insert(self._data.levelMap[v.battletype], data)
    end
  end
end

function DM_StarMirage:OnSGetPointsCollection(protocol)
  while self._data.accumulateRewardList[#self._data.accumulateRewardList] do
    table.remove(self._data.accumulateRewardList, #self._data.accumulateRewardList)
  end
  for i, v in ipairs(protocol.tasks) do
    LogInfoFormat("DM_StarMirage", "-OnSGetPointsCollection- stageId = %s, status = %s ---", v.id, v.status)
    local data = {}
    data.stageId = v.id
    data.status = v.status
    table.insert(self._data.accumulateRewardList, data)
  end
  for k, v in pairs(protocol.points) do
    self._data.accumulatePoints[k] = v
    LogInfoFormat("DM_StarMirage", "-OnSGetPointsCollection- itemId = %s, num = %s ---", k, v)
  end
end

function DM_StarMirage:OnSRefreshPointsTasks(protocol)
  for i, v in ipairs(protocol.tasks) do
    LogInfoFormat("DM_StarMirage", "-OnSRefreshPointsTasks- stageId = %s, status = %s ---", v.id, v.status)
    for _, data in ipairs(self._data.accumulateRewardList) do
      if v.id == data.stageId then
        data.status = v.status
      end
    end
  end
end

return DM_StarMirage
