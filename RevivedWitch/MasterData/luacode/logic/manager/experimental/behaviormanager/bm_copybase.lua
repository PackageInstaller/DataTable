-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_copybase.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LevelStateEnum = (LuaNetManager.GetBeanDef)("protocol.battle.activitybattlenode")
local CStarryMirrorRanking = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorranking")
local BM_CopyBase = class("BM_CopyBase")
BM_CopyBase.Ctor = function(self, data)
  -- function num : 0_0
  self.__data = data
end

BM_CopyBase.GetLevelMap = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local map = {}
  for k,v in pairs((self.__data).levelMap) do
    if not map[k] then
      map[k] = {}
    end
    for _,levelInfo in pairs(v) do
      (table.insert)(map[k], levelInfo)
    end
    ;
    (table.sort)(map[k], function(a, b)
    -- function num : 0_1_0
    do return a.levelId < b.levelId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  return map
end

BM_CopyBase.GetLevelInfo = function(self, type, levelId)
  -- function num : 0_2
  local mapInfo = ((self.__data).levelMap)[type]
  if mapInfo then
    return mapInfo[levelId]
  end
end

BM_CopyBase.GetLevelInfoById = function(self, levelId)
  -- function num : 0_3 , upvalues : _ENV
  for k,mapInfo in pairs((self.__data).levelMap) do
    for id,info in pairs(mapInfo) do
      if id == levelId then
        return info
      end
    end
  end
end

BM_CopyBase.GetLevelRecorder = function(self, levelId)
  -- function num : 0_4 , upvalues : _ENV
  local record = ((self.__data).LevelCfgRecords)[levelId]
  if record then
    return record
  else
    LogErrorFormat("BM_CopyBase", "record with id %s is not exist in levelCfg.(activityId: %s)", levelId, (self.__data).activityId)
  end
end

BM_CopyBase.GetBossLevelInfo = function(self, type, bosslevelornot)
  -- function num : 0_5 , upvalues : _ENV
  local mapInfo = ((self.__data).levelMap)[type]
  if mapInfo then
    for id,levelInfo in pairs(mapInfo) do
      local record = self:GetLevelRecorder(id)
      if (record and record.eventid == (self.__data).activityId and bosslevelornot and record.bosslevelornot == bosslevelornot) or not bosslevelornot and record.bosslevelornot ~= 0 then
        return levelInfo
      end
    end
  end
end

BM_CopyBase.IsBossLevel = function(self, levelId)
  -- function num : 0_6
  local record = self:GetLevelRecorder(levelId)
  if record.bosslevelornot == 0 then
    do return not record end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_CopyBase.IsDailyBossLevel = function(self, levelId)
  -- function num : 0_7
  local record = self:GetLevelRecorder(levelId)
  if record.bosslevelornot ~= 1 then
    do return not record end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_CopyBase.CanEnterBattle = function(self)
  -- function num : 0_8 , upvalues : LevelStateEnum
  local info = self:GetLevelMap()
  local list = info[((self.__data).Type).Easy]
  local firstLevelData = list[1]
  if firstLevelData and firstLevelData.status == LevelStateEnum.LOCK then
    return false
  else
    return true
  end
end

BM_CopyBase.IsUnlockFunctionById = function(self, funcId)
  -- function num : 0_9 , upvalues : LevelStateEnum, _ENV
  if funcId == ((self.__data).Function).Hard then
    if (self.__data).nextTypePeriod > 0 then
      return 0
    else
      local info = self:GetLevelMap()
      local list = info[((self.__data).Type).Hard]
      if list and list[1] then
        return 1
      else
        return -1
      end
    end
  else
    do
      local record = ((self.__data).FuncUnlockCfgRecords)[funcId]
      if record then
        local levelInfo = self:GetLevelInfoById(record.unlocklevel)
        -- DECOMPILER ERROR at PC52: Unhandled construct in 'MakeBoolean' P1

        if levelInfo and levelInfo.levelId == record.unlocklevel and (levelInfo.status == LevelStateEnum.PASSED or levelInfo.status == LevelStateEnum.LOCK) then
          return true
        end
        LogInfoFormat("BM_CopyBase", "levelInfo with funcId %s is not exist.(activityId: %s)", record.unlocklevel, (self.__data).activityId)
      else
        do
          LogErrorFormat("BM_CopyBase", "record with id %s is not exist in funcUnlockCfgRecords.(activityId: %s)", funcId, (self.__data).activityId)
        end
      end
    end
  end
end

BM_CopyBase.GetAfterBattleStory = function(self, levelId)
  -- function num : 0_10 , upvalues : LevelStateEnum, _ENV
  local levelInfo = self:GetLevelInfoById(levelId)
  do
    -- DECOMPILER ERROR at PC12: Unhandled construct in 'MakeBoolean' P1

    if levelInfo and levelInfo.status == LevelStateEnum.CLEAR then
      local record = self:GetLevelRecorder(levelId)
      if record and record.afterbattleplot ~= -1 then
        return record.afterbattleplot
      end
    end
    LogErrorFormat("BM_CopyBase", "levelInfo with id %s is not exist.(activityId: %s)", levelId, (self.__data).activityId)
  end
end

BM_CopyBase.GetClearLevelIdAndPlotId = function(self, type)
  -- function num : 0_11 , upvalues : _ENV, LevelStateEnum
  if self:CanEnterBattle() then
    local info = self:GetLevelMap()
    local list = info[type]
    if list then
      for i,v in ipairs(list) do
        local record = self:GetLevelRecorder(v.levelId)
        if v.status == LevelStateEnum.CLEAR and record and record.afterbattleplot ~= -1 then
          return v.levelId, record.afterbattleplot
        end
      end
    end
  end
end

BM_CopyBase.GetRankBossInfo = function(self)
  -- function num : 0_12 , upvalues : _ENV, CStarryMirrorRanking, LevelStateEnum
  if not (self.__data).activityId then
    LogError("BM_CopyBase:GetRankBossInfo", "activityId is null.")
  end
  local list = {}
  local allIds = CStarryMirrorRanking:GetAllIds()
  for i = 1, #allIds do
    local record = CStarryMirrorRanking:GetRecorder(allIds[i])
    if record.eventid == (self.__data).activityId then
      local levelInfo = self:GetLevelInfoById(record.id)
      if levelInfo and (levelInfo.status == LevelStateEnum.PASSED or levelInfo.status == LevelStateEnum.LOCK) then
        (table.insert)(list, record)
      end
    end
  end
  ;
  (table.sort)(list, function(a, b)
    -- function num : 0_12_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return list
end

BM_CopyBase.IsPlayGuideClickEffect = function(self)
  -- function num : 0_13 , upvalues : LevelStateEnum
  local info = self:GetLevelMap()
  local list = info[((self.__data).Type).Easy]
  local firstLevelData = list[1]
  if (firstLevelData and firstLevelData.status == LevelStateEnum.UNCLEAR) or firstLevelData.status == LevelStateEnum.BEFORE_CLEAR then
    return true
  end
end

BM_CopyBase.GetFirstLevelId = function(self)
  -- function num : 0_14
  local info = self:GetLevelMap()
  local list = info[((self.__data).Type).Easy]
  local firstLevelData = list[1]
  return firstLevelData.levelId
end

BM_CopyBase.SetLevelStatus = function(self, type, levelId, status)
  -- function num : 0_15 , upvalues : _ENV
  local levelInfo = self:GetLevelInfo(type, levelId)
  if levelInfo then
    local sUpdateActivityBattleList = (LuaNetManager.CreateProtocol)("protocol.battle.supdateactivitybattlelist")
    sUpdateActivityBattleList.activityId = (self.__data).activityId
    local activityBattleNode = (LuaNetManager.CreateBean)("protocol.battle.activitybattlenode")
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
    ;
    (table.insert)(sUpdateActivityBattleList.battleNodes, activityBattleNode)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshLevelList, nil, sUpdateActivityBattleList)
  else
    do
      LogErrorFormat("BM_CopyBase", "--- type = %s, levelId = %s, status = %s, activityId = %s ---", type, levelId, status, (self.__data).activityId)
    end
  end
end

return BM_CopyBase

