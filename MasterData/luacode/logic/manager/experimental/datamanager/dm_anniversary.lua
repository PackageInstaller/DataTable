local DM_Anniversary = class("DM_Anniversary")

function DM_Anniversary:Ctor()
  self._data = NekoData.Data.anniversary
  self._data.levelMap = {}
  self._data.nextTypePeriod = nil
  self._data.dailySupplyData = nil
  self._data.dailytaskData = {}
  self._data.cumulativeTaskData = nil
  self._data.firstDrama = nil
  self._data.package = nil
end

function DM_Anniversary:Clear()
  for k, v in pairs(self._data.levelMap) do
    self._data.levelMap[k] = nil
  end
  self._data.nextTypePeriod = nil
  self._data.dailySupplyData = nil
  for k, v in pairs(self._data.dailytaskData) do
    self._data.dailytaskData[k] = nil
  end
  self._data.cumulativeTaskData = nil
  self._data.firstDrama = nil
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
  self._data.package = nil
end

local function AddGameTimer(self)
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
  if self._data.nextTypePeriod > 0 then
    self._gameTimerID = GameTimer.AddTask(math.ceil(self._data.nextTypePeriod / 1000), 0, function()
      local protocol = LuaNetManager.CreateProtocol("protocol.battle.cgetactivitybattlelist")
      protocol.activityId = DataCommon.Activities.Anniversary
      protocol:Send()
    end)
  end
end

function DM_Anniversary:OnSGetActivityBattleList(protocol)
  self._data.nextTypePeriod = protocol.time2NextPeriod
  AddGameTimer(self)
  for k, v in pairs(self._data.levelMap) do
    self._data.levelMap[k] = nil
  end
  for i, v in ipairs(protocol.battleNodes) do
    LogInfoFormat("DM_Anniversary", "-OnSGetActivityBattleList- levelId = %s, status = %s, bossLevel = %s, first = %s, lefttime = %s, lefthp = %s, level = %s ---", v.id, v.status, v.bossLevel, v.first, v.lefttime, v.lefthp, v.level)
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
    data.leftTime = v.lefttime
    data.leftHP = v.lefthp
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

function DM_Anniversary:OnSUpdateActivityBattleList(protocol)
  for i, v in ipairs(protocol.battleNodes) do
    LogInfoFormat("DM_Anniversary", "-OnSUpdateActivityBattleList- levelId = %s, status = %s, bossLevel = %s, first = %s, lefttime = %s, lefthp = %s ---", v.id, v.status, v.bossLevel, v.first, v.lefttime, v.lefthp)
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
    data.leftTime = v.lefttime
    data.leftHP = v.lefthp
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

function DM_Anniversary:OnSAnniversarySupply(protocol)
  self._data.dailySupplyData = protocol.supply
end

function DM_Anniversary:OnSActivityTasks(protocol)
  for k, v in pairs(self._data.dailytaskData) do
    self._data.dailytaskData[k] = nil
  end
  for i, v in ipairs(protocol.activityTasks) do
    self._data.dailytaskData[v.taskid] = {
      taskId = v.taskid,
      taskStatus = v.taskstatus,
      taskCurProgress = v.conditions[1].value,
      taskDestProgress = v.conditions[1].destValue
    }
  end
end

function DM_Anniversary:OnSRefreshActivityTask(protocol)
  local data = self._data.dailytaskData[protocol.taskinfo.taskid]
  if data then
    data.taskStatus = protocol.taskinfo.taskstatus
  else
    LogInfoFormat("DM_Anniversary", "no id %s in tasks", protocol.taskinfo.taskid)
  end
end

function DM_Anniversary:OnSTaskFinishProgress(protocol)
  self._data.cumulativeTaskData = nil
  for k, v in pairs(protocol.tasks) do
    self._data.cumulativeTaskData = {
      status = v.status,
      num = v.num,
      taskId = k
    }
  end
  self._data.firstDrama = protocol.firstDrama ~= 1
end

function DM_Anniversary:SetLevelStatus(type, levelId, status)
  LogInfoFormat("DM_Anniversary", "type = %s, levelId = %s, status = %s", type, levelId, status)
  local levelInfo = NekoData.BehaviorManager.BM_Anniversary:GetLevelInfo(type, levelId)
  if levelInfo then
    LogInfoFormat("DM_Anniversary", "curStatus = %s, status = %s", levelInfo.status, status)
    levelInfo.status = status
  end
end

function DM_Anniversary:OnSOpenAnniversaryDraw(protocol)
  self._data.package = {}
  self._data.package.award = protocol.award
  self._data.package.score = protocol.score
  self._data.package.leftTime = protocol.leftTime
  if self._packageGameTimerID then
    GameTimer.RemoveTask(self._packageGameTimerID)
    self._packageGameTimerID = nil
  end
  if protocol.leftTime > 0 then
    self._packageGameTimerID = GameTimer.AddTask(math.ceil(protocol.leftTime / 1000), 0, function()
      self._data.package = nil
    end)
  else
    self._data.package = nil
  end
end

return DM_Anniversary
