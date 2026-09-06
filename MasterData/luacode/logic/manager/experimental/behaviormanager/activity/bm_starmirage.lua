local LevelStateEnum = LuaNetManager.GetBeanDef("protocol.battle.activitybattlenode")
local CShopTypeConfig = BeanManager.GetTableByName("recharge.cshoptypeconfig")
local CStarrymirrorlevel = BeanManager.GetTableByName("dungeonselect.cstarrymirrorlevel")
local CStarrymirrorfuncunlock = BeanManager.GetTableByName("dungeonselect.cstarrymirrorfuncunlock")
local CStarryMirrorRanking = BeanManager.GetTableByName("dungeonselect.cstarrymirrorranking")
local BM_StarMirage = class("BM_StarMirage")

function BM_StarMirage:Ctor()
  self._data = NekoData.Data.activities.starmirage
  self._functionUnlockRecords = {}
  local allIds = CStarrymirrorfuncunlock:GetAllIds()
  for i = 1, #allIds do
    local record = CStarrymirrorfuncunlock:GetRecorder(allIds[i])
    self._functionUnlockRecords[record.id] = record
  end
  self._rankBossRecords = {}
  allIds = CStarryMirrorRanking:GetAllIds()
  for i = 1, #allIds do
    local record = CStarryMirrorRanking:GetRecorder(allIds[i])
    if record.eventid == DataCommon.Activities.StarMirage then
      self._rankBossRecords[record.id] = record
    end
  end
end

function BM_StarMirage:GetAccumulateRewardList()
  return self._data.accumulateRewardList
end

function BM_StarMirage:GetAccumulatePointsById(itemId)
  return self._data.accumulatePoints[itemId] or 0
end

function BM_StarMirage:ShowRedDot()
  for i, v in ipairs(self._data.accumulateRewardList) do
    if v.status == 1 then
      return true
    end
  end
end

function BM_StarMirage:GetLevelListByType(type)
  return self._data.levelMap[type]
end

function BM_StarMirage:GetLevelMap()
  return self._data.levelMap
end

function BM_StarMirage:GetLevelInfo(type, levelId)
  local list = self._data.levelMap[type]
  if list then
    for i, v in ipairs(list) do
      if v.levelId == levelId then
        return v
      end
    end
  end
end

function BM_StarMirage:GetLevelInfoById(levelId)
  for k, list in pairs(self._data.levelMap) do
    for i, v in ipairs(list) do
      if v.levelId == levelId then
        return v
      end
    end
  end
end

function BM_StarMirage:IsBossLevel(levelId)
  local record = CStarrymirrorlevel:GetRecorder(levelId)
  if record then
    return record.bosslevelornot == 2
  end
end

function BM_StarMirage:CanEnterBattle()
  local list = self._data.levelMap[DataCommon.StarMirage.Type.Easy]
  local firstLevelData = list[1]
  if firstLevelData and firstLevelData.status == LevelStateEnum.LOCK then
    return false
  else
    return true
  end
end

function BM_StarMirage:IsUnlockFunctionById(id)
  if id == DataCommon.StarMirage.Function.HardId then
    if self._data.nextTypePeriod > 0 then
      return 0
    else
      local list = self._data.levelMap[DataCommon.StarMirage.Type.Hard]
      if list and list[1] then
        return 1
      else
        return -1
      end
    end
  else
    local record = self._functionUnlockRecords[id]
    if record then
      for k, v in pairs(self._data.levelMap) do
        for i, levelData in ipairs(v) do
          if levelData.levelId == record.unlocklevel and (levelData.status == LevelStateEnum.PASSED or levelData.status == LevelStateEnum.LOCK) then
            return true
          end
        end
      end
    else
      LogError("id Error!")
    end
  end
end

function BM_StarMirage:GetAfterBattleStory(levelId)
  local levelInfo = self:GetLevelInfoById(levelId)
  if levelInfo and levelInfo.status ~= LevelStateEnum.PASSED then
    local record = CStarrymirrorlevel:GetRecorder(levelId)
    if record and record.afterbattleplot ~= -1 then
      return record.afterbattleplot
    end
  end
end

function BM_StarMirage:GetRankBossInfo()
  local list = {}
  for k, v in pairs(self._rankBossRecords) do
    local levelInfo = self:GetLevelInfoById(k)
    if levelInfo and levelInfo.status == LevelStateEnum.PASSED or levelInfo.status == LevelStateEnum.LOCK then
      table.insert(list, v)
    end
  end
  table.sort(list, function(a, b)
    return a.id < b.id
  end)
  return list
end

function BM_StarMirage:IsPlayGuideClickEffect()
  local list = self._data.levelMap[DataCommon.StarMirage.Type.Easy]
  local firstLevelData = list[1]
  if firstLevelData and firstLevelData.status == LevelStateEnum.UNCLEAR then
    return true
  end
end

return BM_StarMirage
