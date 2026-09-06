local DM_CopyBase = class("DM_CopyBase")

function DM_CopyBase:Ctor(data, other)
  self.__data = data
  self.__data.levelMap = {}
  self.__data.nextTypePeriod = nil
  self.__data.LevelCfg = other.LevelCfg
  self.__data.LevelCfgRecords = {}
  self.__data.FuncUnlockCfg = other.FunctionUnlockCfg
  self.__data.FuncUnlockCfgRecords = {}
  self.__data.Type = other.Type
  self.__data.Function = other.Function
  self.__data.activityId = nil
  self.__gameTimerId = nil
end

function DM_CopyBase:Clear()
  for k, v in pairs(self.__data.levelMap) do
    self.__data.levelMap[k] = nil
  end
  self.__data.nextTypePeriod = nil
  self.__data.activityId = nil
  self.__gameTimerId = nil
end

local function InitCfgByActivityId(self)
  LogInfoFormat("DM_CopyBase", "-InitCfgByActivityId- activityId = %s", self.__data.activityId)
  for k, v in pairs(self.__data.LevelCfgRecords) do
    self.__data.LevelCfgRecords[k] = nil
  end
  local allIds = self.__data.LevelCfg:GetAllIds()
  for i = 1, #allIds do
    local record = self.__data.LevelCfg:GetRecorder(allIds[i])
    if record.eventid == self.__data.activityId then
      self.__data.LevelCfgRecords[record.id] = record
    end
  end
  for k, v in pairs(self.__data.FuncUnlockCfgRecords) do
    self.__data.FuncUnlockCfgRecords[k] = nil
  end
  allIds = self.__data.FuncUnlockCfg:GetAllIds()
  for i = 1, #allIds do
    local record = self.__data.FuncUnlockCfg:GetRecorder(allIds[i])
    if record.eventid == self.__data.activityId then
      self.__data.FuncUnlockCfgRecords[record.id] = record
    end
  end
end

local function AddGameTimer(self)
  if self.__gameTimerId then
    GameTimer.RemoveTask(self.__gameTimerId)
    self.__gameTimerId = nil
  end
  if self.__data.nextTypePeriod > 0 then
    self.__gameTimerId = GameTimer.AddTask(math.ceil(self.__data.nextTypePeriod / 1000), 0, function()
      local protocol = LuaNetManager.CreateProtocol("protocol.battle.cgetactivitybattlelist")
      protocol.activityId = self.__data.activityId
      protocol:Send()
    end)
  end
end

function DM_CopyBase:OnSGetActivityBattleList(protocol)
  self.__data.activityId = protocol.activityId
  InitCfgByActivityId(self)
  self.__data.nextTypePeriod = protocol.time2NextPeriod
  AddGameTimer(self)
  for k, v in pairs(self.__data.levelMap) do
    self.__data.levelMap[k] = nil
  end
  for i, v in ipairs(protocol.battleNodes) do
    LogInfoFormat("DM_CopyBase", "-OnSGetActivityBattleList- activityId = %s, levelId = %s, status = %s, recommendLevel = %s, difficulty = %s, costSpirit = %s, first = %s, bossLevel = %s, lefttime = %s, lefthp = %s ---", self.__data.activityId, v.id, v.status, v.level, v.battletype, v.spirit, v.first, v.bossLevel, v.lefttime, v.lefthp)
    local data = {}
    data.levelId = v.id
    data.status = v.status
    data.recommendLevel = v.level
    data.difficulty = v.battletype
    data.costSpirit = v.spirit
    data.firstGet = v.first == 1
    data.firstItems = v.firstItems
    data.randItems = v.randItems
    data.normalItems = v.normalItems
    data.bossLevel = v.bossLevel
    data.leftTime = v.lefttime
    data.leftHP = v.lefthp
    if not self.__data.levelMap[data.difficulty] then
      self.__data.levelMap[data.difficulty] = {}
    end
    self.__data.levelMap[data.difficulty][data.levelId] = data
  end
end

function DM_CopyBase:OnSUpdateActivityBattleList(protocol)
  if protocol.activityId ~= self.__data.activityId then
    LogErrorFormat("DM_CopyBase", "activityId is not match. activityId: %s, initActivityId = %s", protocol.activityId, self.__data.activityId)
    return
  end
  for i, v in ipairs(protocol.battleNodes) do
    LogInfoFormat("DM_CopyBase", "-OnSUpdateActivityBattleList- activityId = %s, levelId = %s, status = %s, recommendLevel = %s, difficulty = %s, costSpirit = %s, first = %s, bossLevel = %s, lefttime = %s, lefthp = %s ---", self.__data.activityId, v.id, v.status, v.level, v.battletype, v.spirit, v.first, v.bossLevel, v.lefttime, v.lefthp)
    local data = {}
    data.levelId = v.id
    data.status = v.status
    data.recommendLevel = v.level
    data.difficulty = v.battletype
    data.costSpirit = v.spirit
    data.firstGet = v.first == 1
    data.firstItems = v.firstItems
    data.randItems = v.randItems
    data.normalItems = v.normalItems
    data.bossLevel = v.bossLevel
    data.leftTime = v.lefttime
    data.leftHP = v.lefthp
    if not self.__data.levelMap[data.difficulty] then
      self.__data.levelMap[data.difficulty] = {}
    end
    self.__data.levelMap[data.difficulty][data.levelId] = data
  end
end

function DM_CopyBase:SetLevelStatus(type, levelId, status)
  LogInfoFormat("DM_CopyBase", "-SetLevelStatus- activityId = %s, type = %s, levelId = %s, status = %s", self.__data.activityId, type, levelId, status)
  local mapInfo = self.__data.levelMap[type]
  if not mapInfo then
    LogError("DM_CopyBase", "data error.")
  else
    local levelInfo = mapInfo[levelId]
    if not levelInfo then
      LogError("DM_CopyBase", "data error.")
    else
      LogInfoFormat("DM_CopyBase", "curStatus = %s, status = %s", levelInfo.status, status)
      levelInfo.status = status
    end
  end
end

return DM_CopyBase
