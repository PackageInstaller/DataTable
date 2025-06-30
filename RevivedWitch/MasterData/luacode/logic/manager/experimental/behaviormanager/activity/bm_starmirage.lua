-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_starmirage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LevelStateEnum = (LuaNetManager.GetBeanDef)("protocol.battle.activitybattlenode")
local CShopTypeConfig = (BeanManager.GetTableByName)("recharge.cshoptypeconfig")
local CStarrymirrorlevel = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel")
local CStarrymirrorfuncunlock = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorfuncunlock")
local CStarryMirrorRanking = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorranking")
local BM_StarMirage = class("BM_StarMirage")
BM_StarMirage.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, CStarrymirrorfuncunlock, CStarryMirrorRanking
  self._data = ((NekoData.Data).activities).starmirage
  self._functionUnlockRecords = {}
  local allIds = CStarrymirrorfuncunlock:GetAllIds()
  for i = 1, #allIds do
    local record = CStarrymirrorfuncunlock:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._functionUnlockRecords)[record.id] = record
  end
  self._rankBossRecords = {}
  allIds = CStarryMirrorRanking:GetAllIds()
  for i = 1, #allIds do
    local record = CStarryMirrorRanking:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R7 in 'UnsetPending'

    if record.eventid == (DataCommon.Activities).StarMirage then
      (self._rankBossRecords)[record.id] = record
    end
  end
end

BM_StarMirage.GetAccumulateRewardList = function(self)
  -- function num : 0_1
  return (self._data).accumulateRewardList
end

BM_StarMirage.GetAccumulatePointsById = function(self, itemId)
  -- function num : 0_2
  return ((self._data).accumulatePoints)[itemId] or 0
end

BM_StarMirage.ShowRedDot = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for i,v in ipairs((self._data).accumulateRewardList) do
    if v.status == 1 then
      return true
    end
  end
end

BM_StarMirage.GetLevelListByType = function(self, type)
  -- function num : 0_4
  return ((self._data).levelMap)[type]
end

BM_StarMirage.GetLevelMap = function(self)
  -- function num : 0_5
  return (self._data).levelMap
end

BM_StarMirage.GetLevelInfo = function(self, type, levelId)
  -- function num : 0_6 , upvalues : _ENV
  local list = ((self._data).levelMap)[type]
  if list then
    for i,v in ipairs(list) do
      if v.levelId == levelId then
        return v
      end
    end
  end
end

BM_StarMirage.GetLevelInfoById = function(self, levelId)
  -- function num : 0_7 , upvalues : _ENV
  for k,list in pairs((self._data).levelMap) do
    for i,v in ipairs(list) do
      if v.levelId == levelId then
        return v
      end
    end
  end
end

BM_StarMirage.IsBossLevel = function(self, levelId)
  -- function num : 0_8 , upvalues : CStarrymirrorlevel
  local record = CStarrymirrorlevel:GetRecorder(levelId)
  if record.bosslevelornot ~= 2 then
    do return not record end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_StarMirage.CanEnterBattle = function(self)
  -- function num : 0_9 , upvalues : _ENV, LevelStateEnum
  local list = ((self._data).levelMap)[((DataCommon.StarMirage).Type).Easy]
  local firstLevelData = list[1]
  if firstLevelData and firstLevelData.status == LevelStateEnum.LOCK then
    return false
  else
    return true
  end
end

BM_StarMirage.IsUnlockFunctionById = function(self, id)
  -- function num : 0_10 , upvalues : _ENV, LevelStateEnum
  if id == ((DataCommon.StarMirage).Function).HardId then
    if (self._data).nextTypePeriod > 0 then
      return 0
    else
      local list = ((self._data).levelMap)[((DataCommon.StarMirage).Type).Hard]
      if list and list[1] then
        return 1
      else
        return -1
      end
    end
  else
    do
      local record = (self._functionUnlockRecords)[id]
      if record then
        for k,v in pairs((self._data).levelMap) do
          for i,levelData in ipairs(v) do
            if levelData.levelId == record.unlocklevel and (levelData.status == LevelStateEnum.PASSED or levelData.status == LevelStateEnum.LOCK) then
              return true
            end
          end
        end
      else
        do
          LogError("id Error!")
        end
      end
    end
  end
end

BM_StarMirage.GetAfterBattleStory = function(self, levelId)
  -- function num : 0_11 , upvalues : LevelStateEnum, CStarrymirrorlevel
  local levelInfo = self:GetLevelInfoById(levelId)
  if levelInfo and levelInfo.status ~= LevelStateEnum.PASSED then
    local record = CStarrymirrorlevel:GetRecorder(levelId)
    if record and record.afterbattleplot ~= -1 then
      return record.afterbattleplot
    end
  end
end

BM_StarMirage.GetRankBossInfo = function(self)
  -- function num : 0_12 , upvalues : _ENV, LevelStateEnum
  local list = {}
  for k,v in pairs(self._rankBossRecords) do
    local levelInfo = self:GetLevelInfoById(k)
    if (levelInfo and levelInfo.status == LevelStateEnum.PASSED) or levelInfo.status == LevelStateEnum.LOCK then
      (table.insert)(list, v)
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

BM_StarMirage.IsPlayGuideClickEffect = function(self)
  -- function num : 0_13 , upvalues : _ENV, LevelStateEnum
  local list = ((self._data).levelMap)[((DataCommon.StarMirage).Type).Easy]
  local firstLevelData = list[1]
  if firstLevelData and firstLevelData.status == LevelStateEnum.UNCLEAR then
    return true
  end
end

return BM_StarMirage

