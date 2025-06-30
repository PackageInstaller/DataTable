-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_anniversary.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LevelStateEnum = (LuaNetManager.GetBeanDef)("protocol.battle.activitybattlenode")
local SAnniversarySupply = (LuaNetManager.GetProtocolDef)("protocol.activity.sanniversarysupply")
local TaskStatus = (LuaNetManager.GetBeanDef)("protocol.task.taskstatus")
local TaskFinishProgress = (LuaNetManager.GetBeanDef)("protocol.activity.taskfinishprogress")
local CAnniversarylevel = (BeanManager.GetTableByName)("dungeonselect.canniversarylevel")
local CAnniversaryFuncUnlock = (BeanManager.GetTableByName)("dungeonselect.canniversaryfuncunlock")
local CStarryMirrorRanking = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorranking")
local CActivityTasks = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local BM_Anniversary = class("BM_Anniversary")
BM_Anniversary.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, CAnniversaryFuncUnlock, CStarryMirrorRanking
  self._data = (NekoData.Data).anniversary
  self._functionUnlockRecords = {}
  local allIds = CAnniversaryFuncUnlock:GetAllIds()
  for i = 1, #allIds do
    local record = CAnniversaryFuncUnlock:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._functionUnlockRecords)[record.id] = record
  end
  self._rankBossRecords = {}
  allIds = CStarryMirrorRanking:GetAllIds()
  for i = 1, #allIds do
    local record = CStarryMirrorRanking:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R7 in 'UnsetPending'

    if record.eventid == (DataCommon.Activities).Anniversary then
      (self._rankBossRecords)[record.id] = record
    end
  end
end

BM_Anniversary.GetLevelMap = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local map = {}
  for k,v in pairs((self._data).levelMap) do
    if not map[k] then
      map[k] = {}
    end
    for _,value in ipairs(v) do
      (table.insert)(map[k], value)
    end
  end
  return map
end

BM_Anniversary.GetLevelInfo = function(self, type, levelId)
  -- function num : 0_2 , upvalues : _ENV
  local list = ((self._data).levelMap)[type]
  if list then
    for i,v in ipairs(list) do
      if v.levelId == levelId then
        return v
      end
    end
  end
end

BM_Anniversary.GetLevelInfoById = function(self, levelId)
  -- function num : 0_3 , upvalues : _ENV
  for k,list in pairs((self._data).levelMap) do
    for i,v in ipairs(list) do
      if v.levelId == levelId then
        return v
      end
    end
  end
end

BM_Anniversary.GetBossLevelInfo = function(self, type, bosslevelornot)
  -- function num : 0_4 , upvalues : _ENV, CAnniversarylevel
  local list = ((self._data).levelMap)[type]
  if list then
    for i,v in ipairs(list) do
      local record = CAnniversarylevel:GetRecorder(v.levelId)
      if record.bosslevelornot == bosslevelornot then
        return v
      end
    end
  end
end

BM_Anniversary.IsBossLevel = function(self, levelId)
  -- function num : 0_5 , upvalues : CAnniversarylevel
  local record = CAnniversarylevel:GetRecorder(levelId)
  if record.bosslevelornot == 0 then
    do return not record end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_Anniversary.IsDailyBossLevel = function(self, levelId)
  -- function num : 0_6 , upvalues : CAnniversarylevel
  local record = CAnniversarylevel:GetRecorder(levelId)
  if record.bosslevelornot ~= 1 then
    do return not record end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_Anniversary.CanEnterBattle = function(self)
  -- function num : 0_7 , upvalues : _ENV, LevelStateEnum
  local list = ((self._data).levelMap)[((DataCommon.Anniversary).Type).Easy]
  local firstLevelData = list[1]
  if firstLevelData and firstLevelData.status == LevelStateEnum.LOCK then
    return false
  else
    return true
  end
end

BM_Anniversary.IsUnlockFunctionById = function(self, id)
  -- function num : 0_8 , upvalues : _ENV, LevelStateEnum
  if id == ((DataCommon.Anniversary).Function).Hard then
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

BM_Anniversary.GetAfterBattleStory = function(self, levelId)
  -- function num : 0_9 , upvalues : LevelStateEnum, CAnniversarylevel
  local levelInfo = self:GetLevelInfoById(levelId)
  if levelInfo and levelInfo.status == LevelStateEnum.CLEAR then
    local record = CAnniversarylevel:GetRecorder(levelId)
    if record and record.afterbattleplot ~= -1 then
      return record.afterbattleplot
    end
  end
end

BM_Anniversary.GetClearLevelIdAndPlotId = function(self, type)
  -- function num : 0_10 , upvalues : _ENV, CAnniversarylevel, LevelStateEnum
  if self:CanEnterBattle() then
    local list = ((self._data).levelMap)[type]
    if list then
      for i,v in ipairs(list) do
        local record = CAnniversarylevel:GetRecorder(v.levelId)
        if v.status == LevelStateEnum.CLEAR and record and record.afterbattleplot ~= -1 then
          return v.levelId, record.afterbattleplot
        end
      end
    end
  end
end

BM_Anniversary.ShowRedDot = function(self)
  -- function num : 0_11
  if self:ShowDailySupplyRedDot() then
    return true
  end
  if self:ShowDailyTaskRedDot() then
    return true
  end
  if self:ShowCumulativeTaskRedDot() then
    return true
  end
  if self:HasTaskAward() then
    return true
  end
  if self:HasFreeGood() then
    return true
  end
  if self:HasScoreAward() then
    return true
  end
end

BM_Anniversary.GetRankBossInfo = function(self)
  -- function num : 0_12 , upvalues : _ENV, LevelStateEnum
  local list = {}
  for k,v in pairs(self._rankBossRecords) do
    local levelInfo = self:GetLevelInfoById(k)
    if levelInfo and (levelInfo.status == LevelStateEnum.PASSED or levelInfo.status == LevelStateEnum.LOCK) then
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

BM_Anniversary.IsPlayGuideClickEffect = function(self)
  -- function num : 0_13 , upvalues : _ENV, LevelStateEnum
  local list = ((self._data).levelMap)[((DataCommon.Anniversary).Type).Easy]
  local firstLevelData = list[1]
  if (firstLevelData and firstLevelData.status == LevelStateEnum.UNCLEAR) or firstLevelData.status == LevelStateEnum.BEFORE_CLEAR then
    return true
  end
end

BM_Anniversary.GetDailySupplyData = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local list = {}
  if (self._data).dailySupplyData then
    for k,v in pairs((self._data).dailySupplyData) do
      (table.insert)(list, {id = k, status = v})
    end
  else
    do
      LogError("lack dailysupply data!")
      return list
    end
  end
end

BM_Anniversary.ShowDailySupplyRedDot = function(self)
  -- function num : 0_15 , upvalues : _ENV, SAnniversarySupply
  if self:IsUnlockFunctionById(((DataCommon.Anniversary).Function).DailySupply) then
    if (self._data).dailySupplyData then
      for k,v in pairs((self._data).dailySupplyData) do
        if v == SAnniversarySupply.UNLOCKED then
          return true
        end
      end
    else
      do
        LogError("lack dailysupply data!")
      end
    end
  end
end

BM_Anniversary.GetDailyTaskList = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local list = {}
  for k,v in pairs((self._data).dailytaskData) do
    (table.insert)(list, v)
  end
  return list
end

BM_Anniversary.ShowDailyTaskRedDot = function(self)
  -- function num : 0_17 , upvalues : _ENV, TaskStatus
  for k,v in pairs((self._data).dailytaskData) do
    if v.taskStatus == TaskStatus.FINISHED then
      return true
    end
  end
end

BM_Anniversary.GetCumulativeTaskData = function(self)
  -- function num : 0_18
  return (self._data).cumulativeTaskData
end

BM_Anniversary.ShowCumulativeTaskRedDot = function(self)
  -- function num : 0_19 , upvalues : TaskFinishProgress
  if ((self._data).cumulativeTaskData).status ~= TaskFinishProgress.UNLOCKED then
    do return not (self._data).cumulativeTaskData end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_Anniversary.IsDisplayFirstDrama = function(self)
  -- function num : 0_20
  return (self._data).firstDrama
end

BM_Anniversary.SetLevelStatus = function(self, type, levelId, status)
  -- function num : 0_21 , upvalues : _ENV
  ((NekoData.DataManager).DM_Anniversary):SetLevelStatus(type, levelId, status)
  local levelInfo = self:GetLevelInfo(type, levelId)
  if levelInfo then
    local sUpdateActivityBattleList = (LuaNetManager.CreateProtocol)("protocol.battle.supdateactivitybattlelist")
    sUpdateActivityBattleList.activityId = (DataCommon.Activities).Anniversary
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
      LogErrorFormat("BM_Anniversary", "--- type = %s, levelId = %s, status = %s ---", type, levelId, status)
    end
  end
end

BM_Anniversary.IsPackageOpen = function(self)
  -- function num : 0_22
  do return not (self._data).package or ((self._data).package).leftTime > 0 end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_Anniversary.GetPackageInfo = function(self)
  -- function num : 0_23
  return (self._data).package
end

BM_Anniversary.MainRedDot = function(self)
  -- function num : 0_24
  if self:ShowDailySupplyRedDot() then
    return true
  end
  if self:ShowDailyTaskRedDot() then
    return true
  end
  if self:ShowCumulativeTaskRedDot() then
    return true
  end
end

BM_Anniversary.HasTaskAward = function(self)
  -- function num : 0_25 , upvalues : _ENV, CActivityTasks
  if not self:IsPackageOpen() then
    return false
  end
  return ((NekoData.BehaviorManager).BM_ActivityTasks):HaveFinishedTask(CActivityTasks.ANNIVERSARY_DRAW)
end

BM_Anniversary.HasFreeGood = function(self)
  -- function num : 0_26 , upvalues : _ENV
  if not self:IsPackageOpen() then
    return false
  end
  if not ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID(((DataCommon.Anniversary).Other).ShopId) then
    local shopData = {}
  end
  local allFreeSoldOut = true
  for _,good in ipairs(shopData) do
    if good.discountPrice == 0 then
      allFreeSoldOut = true
      if good.goodRemain ~= 0 then
        allFreeSoldOut = false
        break
      end
    end
  end
  do
    return not allFreeSoldOut
  end
end

BM_Anniversary.HasScoreAward = function(self)
  -- function num : 0_27 , upvalues : _ENV
  if not self:IsPackageOpen() then
    return false
  end
  for _,v in ipairs(((self._data).package).award) do
    if v == 1 then
      return true
    end
  end
end

return BM_Anniversary

