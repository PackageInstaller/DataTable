local LevelStateEnum = LuaNetManager.GetBeanDef("protocol.battle.activitybattlenode")
local CStarryMirrorRanking = BeanManager.GetTableByName("dungeonselect.cstarrymirrorranking")
local BM_CopyBase = class("BM_CopyBase")

function BM_CopyBase:Ctor(data)
  self.__data = data
end

function BM_CopyBase:GetLevelMap()
  local map = {}
  for k, v in pairs(self.__data.levelMap) do
    if not map[k] then
      map[k] = {}
    end
    for _, levelInfo in pairs(v) do
      table.insert(map[k], levelInfo)
    end
    table.sort(map[k], function(a, b)
      return a.levelId < b.levelId
    end)
  end
  return map
end

function BM_CopyBase:GetLevelInfo(type, levelId)
  local mapInfo = self.__data.levelMap[type]
  if mapInfo then
    return mapInfo[levelId]
  end
end

function BM_CopyBase:GetLevelInfoById(levelId)
  for k, mapInfo in pairs(self.__data.levelMap) do
    for id, info in pairs(mapInfo) do
      if id == levelId then
        return info
      end
    end
  end
end

function BM_CopyBase:GetLevelRecorder(levelId)
  local record = self.__data.LevelCfgRecords[levelId]
  if record then
    return record
  else
    LogErrorFormat("BM_CopyBase", "record with id %s is not exist in levelCfg.(activityId: %s)", levelId, self.__data.activityId)
  end
end

function BM_CopyBase:GetBossLevelInfo(type, bosslevelornot)
  local mapInfo = self.__data.levelMap[type]
  if mapInfo then
    for id, levelInfo in pairs(mapInfo) do
      local record = self:GetLevelRecorder(id)
      if record and record.eventid == self.__data.activityId and bosslevelornot and record.bosslevelornot == bosslevelornot or not bosslevelornot and record.bosslevelornot ~= 0 then
        return levelInfo
      end
    end
  end
end

function BM_CopyBase:IsBossLevel(levelId)
  local record = self:GetLevelRecorder(levelId)
  if record then
    return record.bosslevelornot ~= 0
  end
end

function BM_CopyBase:IsDailyBossLevel(levelId)
  local record = self:GetLevelRecorder(levelId)
  if record then
    return record.bosslevelornot == 1
  end
end

function BM_CopyBase:CanEnterBattle()
  local info = self:GetLevelMap()
  local list = info[self.__data.Type.Easy]
  local firstLevelData = list[1]
  if firstLevelData and firstLevelData.status == LevelStateEnum.LOCK then
    return false
  else
    return true
  end
end

function BM_CopyBase:IsUnlockFunctionById(funcId)
  if funcId == self.__data.Function.Hard then
    if self.__data.nextTypePeriod > 0 then
      return 0
    else
      local info = self:GetLevelMap()
      local list = info[self.__data.Type.Hard]
      if list and list[1] then
        return 1
      else
        return -1
      end
    end
  else
    local record = self.__data.FuncUnlockCfgRecords[funcId]
    if record then
      local levelInfo = self:GetLevelInfoById(record.unlocklevel)
      if levelInfo then
        if levelInfo.levelId == record.unlocklevel and (levelInfo.status == LevelStateEnum.PASSED or levelInfo.status == LevelStateEnum.LOCK) then
          return true
        end
      else
        LogInfoFormat("BM_CopyBase", "levelInfo with funcId %s is not exist.(activityId: %s)", record.unlocklevel, self.__data.activityId)
      end
    else
      LogErrorFormat("BM_CopyBase", "record with id %s is not exist in funcUnlockCfgRecords.(activityId: %s)", funcId, self.__data.activityId)
    end
  end
end

function BM_CopyBase:GetAfterBattleStory(levelId)
  local levelInfo = self:GetLevelInfoById(levelId)
  if levelInfo then
    if levelInfo.status == LevelStateEnum.CLEAR then
      local record = self:GetLevelRecorder(levelId)
      if record and record.afterbattleplot ~= -1 then
        return record.afterbattleplot
      end
    end
  else
    LogErrorFormat("BM_CopyBase", "levelInfo with id %s is not exist.(activityId: %s)", levelId, self.__data.activityId)
  end
end

function BM_CopyBase:GetClearLevelIdAndPlotId(type)
  if self:CanEnterBattle() then
    local info = self:GetLevelMap()
    local list = info[type]
    if list then
      for i, v in ipairs(list) do
        local record = self:GetLevelRecorder(v.levelId)
        if v.status == LevelStateEnum.CLEAR and record and record.afterbattleplot ~= -1 then
          return v.levelId, record.afterbattleplot
        end
      end
    end
  end
end

function BM_CopyBase:GetRankBossInfo()
  if not self.__data.activityId then
    LogError("BM_CopyBase:GetRankBossInfo", "activityId is null.")
  end
  local list = {}
  local allIds = CStarryMirrorRanking:GetAllIds()
  for i = 1, #allIds do
    local record = CStarryMirrorRanking:GetRecorder(allIds[i])
    if record.eventid == self.__data.activityId then
      local levelInfo = self:GetLevelInfoById(record.id)
      if levelInfo and (levelInfo.status == LevelStateEnum.PASSED or levelInfo.status == LevelStateEnum.LOCK) then
        table.insert(list, record)
      end
    end
  end
  table.sort(list, function(a, b)
    return a.id < b.id
  end)
  return list
end

function BM_CopyBase:IsPlayGuideClickEffect()
  local info = self:GetLevelMap()
  local list = info[self.__data.Type.Easy]
  local firstLevelData = list[1]
  if firstLevelData and firstLevelData.status == LevelStateEnum.UNCLEAR or firstLevelData.status == LevelStateEnum.BEFORE_CLEAR then
    return true
  end
end

function BM_CopyBase:GetFirstLevelId()
  local info = self:GetLevelMap()
  local list = info[self.__data.Type.Easy]
  local firstLevelData = list[1]
  return firstLevelData.levelId
end

function BM_CopyBase:SetLevelStatus(type, levelId, status)
  local levelInfo = self:GetLevelInfo(type, levelId)
  if levelInfo then
    local sUpdateActivityBattleList = LuaNetManager.CreateProtocol("protocol.battle.supdateactivitybattlelist")
    sUpdateActivityBattleList.activityId = self.__data.activityId
    local activityBattleNode = LuaNetManager.CreateBean("protocol.battle.activitybattlenode")
    activityBattleNode.id = levelInfo.levelId
    activityBattleNode.status = levelInfo.status
    activityBattleNode.level = levelInfo.recommendLevel
    activityBattleNode.battletype = type
    activityBattleNode.spirit = levelInfo.costSpirit
    activityBattleNode.firstItems = levelInfo.firstItems
    activityBattleNode.normalItems = levelInfo.normalItems
    activityBattleNode.randItems = levelInfo.randItems
    if levelInfo.firstGet then
      activityBattleNode.first = 1
    else
      activityBattleNode.first = 0
    end
    activityBattleNode.bossLevel = levelInfo.bossLevel
    activityBattleNode.lefttime = levelInfo.leftTime
    activityBattleNode.lefthp = levelInfo.leftHP
    table.insert(sUpdateActivityBattleList.battleNodes, activityBattleNode)
    LuaNotificationCenter.PostNotification(Common.n_RefreshLevelList, nil, sUpdateActivityBattleList)
  else
    LogErrorFormat("BM_CopyBase", "--- type = %s, levelId = %s, status = %s, activityId = %s ---", type, levelId, status, self.__data.activityId)
  end
end

return BM_CopyBase
