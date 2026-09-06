local LevelStateEnum = LuaNetManager.GetBeanDef("protocol.battle.activitybattlenode")
local SAnniversarySupply = LuaNetManager.GetProtocolDef("protocol.activity.sanniversarysupply")
local TaskStatus = LuaNetManager.GetBeanDef("protocol.task.taskstatus")
local TaskFinishProgress = LuaNetManager.GetBeanDef("protocol.activity.taskfinishprogress")
local CAnniversarylevel = BeanManager.GetTableByName("dungeonselect.canniversarylevel")
local CAnniversaryFuncUnlock = BeanManager.GetTableByName("dungeonselect.canniversaryfuncunlock")
local CStarryMirrorRanking = BeanManager.GetTableByName("dungeonselect.cstarrymirrorranking")
local CActivityTasks = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")
local BM_Anniversary = class("BM_Anniversary")

function BM_Anniversary:Ctor()
  self._data = NekoData.Data.anniversary
  self._functionUnlockRecords = {}
  local allIds = CAnniversaryFuncUnlock:GetAllIds()
  for i = 1, #allIds do
    local record = CAnniversaryFuncUnlock:GetRecorder(allIds[i])
    self._functionUnlockRecords[record.id] = record
  end
  self._rankBossRecords = {}
  allIds = CStarryMirrorRanking:GetAllIds()
  for i = 1, #allIds do
    local record = CStarryMirrorRanking:GetRecorder(allIds[i])
    if record.eventid == DataCommon.Activities.Anniversary then
      self._rankBossRecords[record.id] = record
    end
  end
end

function BM_Anniversary:GetLevelMap()
  local map = {}
  for k, v in pairs(self._data.levelMap) do
    if not map[k] then
      map[k] = {}
    end
    for _, value in ipairs(v) do
      table.insert(map[k], value)
    end
  end
  return map
end

function BM_Anniversary:GetLevelInfo(type, levelId)
  local list = self._data.levelMap[type]
  if list then
    for i, v in ipairs(list) do
      if v.levelId == levelId then
        return v
      end
    end
  end
end

function BM_Anniversary:GetLevelInfoById(levelId)
  for k, list in pairs(self._data.levelMap) do
    for i, v in ipairs(list) do
      if v.levelId == levelId then
        return v
      end
    end
  end
end

function BM_Anniversary:GetBossLevelInfo(type, bosslevelornot)
  local list = self._data.levelMap[type]
  if list then
    for i, v in ipairs(list) do
      local record = CAnniversarylevel:GetRecorder(v.levelId)
      if record.bosslevelornot == bosslevelornot then
        return v
      end
    end
  end
end

function BM_Anniversary:IsBossLevel(levelId)
  local record = CAnniversarylevel:GetRecorder(levelId)
  if record then
    return record.bosslevelornot ~= 0
  end
end

function BM_Anniversary:IsDailyBossLevel(levelId)
  local record = CAnniversarylevel:GetRecorder(levelId)
  if record then
    return record.bosslevelornot == 1
  end
end

function BM_Anniversary:CanEnterBattle()
  local list = self._data.levelMap[DataCommon.Anniversary.Type.Easy]
  local firstLevelData = list[1]
  if firstLevelData and firstLevelData.status == LevelStateEnum.LOCK then
    return false
  else
    return true
  end
end

function BM_Anniversary:IsUnlockFunctionById(id)
  if id == DataCommon.Anniversary.Function.Hard then
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

function BM_Anniversary:GetAfterBattleStory(levelId)
  local levelInfo = self:GetLevelInfoById(levelId)
  if levelInfo and levelInfo.status == LevelStateEnum.CLEAR then
    local record = CAnniversarylevel:GetRecorder(levelId)
    if record and record.afterbattleplot ~= -1 then
      return record.afterbattleplot
    end
  end
end

function BM_Anniversary:GetClearLevelIdAndPlotId(type)
  if self:CanEnterBattle() then
    local list = self._data.levelMap[type]
    if list then
      for i, v in ipairs(list) do
        local record = CAnniversarylevel:GetRecorder(v.levelId)
        if v.status == LevelStateEnum.CLEAR and record and record.afterbattleplot ~= -1 then
          return v.levelId, record.afterbattleplot
        end
      end
    end
  end
end

function BM_Anniversary:ShowRedDot()
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

function BM_Anniversary:GetRankBossInfo()
  local list = {}
  for k, v in pairs(self._rankBossRecords) do
    local levelInfo = self:GetLevelInfoById(k)
    if levelInfo and (levelInfo.status == LevelStateEnum.PASSED or levelInfo.status == LevelStateEnum.LOCK) then
      table.insert(list, v)
    end
  end
  table.sort(list, function(a, b)
    return a.id < b.id
  end)
  return list
end

function BM_Anniversary:IsPlayGuideClickEffect()
  local list = self._data.levelMap[DataCommon.Anniversary.Type.Easy]
  local firstLevelData = list[1]
  if firstLevelData and firstLevelData.status == LevelStateEnum.UNCLEAR or firstLevelData.status == LevelStateEnum.BEFORE_CLEAR then
    return true
  end
end

function BM_Anniversary:GetDailySupplyData()
  local list = {}
  if self._data.dailySupplyData then
    for k, v in pairs(self._data.dailySupplyData) do
      table.insert(list, {id = k, status = v})
    end
  else
    LogError("lack dailysupply data!")
  end
  return list
end

function BM_Anniversary:ShowDailySupplyRedDot()
  if self:IsUnlockFunctionById(DataCommon.Anniversary.Function.DailySupply) then
    if self._data.dailySupplyData then
      for k, v in pairs(self._data.dailySupplyData) do
        if v == SAnniversarySupply.UNLOCKED then
          return true
        end
      end
    else
      LogError("lack dailysupply data!")
    end
  end
end

function BM_Anniversary:GetDailyTaskList()
  local list = {}
  for k, v in pairs(self._data.dailytaskData) do
    table.insert(list, v)
  end
  return list
end

function BM_Anniversary:ShowDailyTaskRedDot()
  for k, v in pairs(self._data.dailytaskData) do
    if v.taskStatus == TaskStatus.FINISHED then
      return true
    end
  end
end

function BM_Anniversary:GetCumulativeTaskData()
  return self._data.cumulativeTaskData
end

function BM_Anniversary:ShowCumulativeTaskRedDot()
  if self._data.cumulativeTaskData then
    return self._data.cumulativeTaskData.status == TaskFinishProgress.UNLOCKED
  end
end

function BM_Anniversary:IsDisplayFirstDrama()
  return self._data.firstDrama
end

function BM_Anniversary:SetLevelStatus(type, levelId, status)
  NekoData.DataManager.DM_Anniversary:SetLevelStatus(type, levelId, status)
  local levelInfo = self:GetLevelInfo(type, levelId)
  if levelInfo then
    local sUpdateActivityBattleList = LuaNetManager.CreateProtocol("protocol.battle.supdateactivitybattlelist")
    sUpdateActivityBattleList.activityId = DataCommon.Activities.Anniversary
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
    LogErrorFormat("BM_Anniversary", "--- type = %s, levelId = %s, status = %s ---", type, levelId, status)
  end
end

function BM_Anniversary:IsPackageOpen()
  return self._data.package and self._data.package.leftTime > 0
end

function BM_Anniversary:GetPackageInfo()
  return self._data.package
end

function BM_Anniversary:MainRedDot()
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

function BM_Anniversary:HasTaskAward()
  if not self:IsPackageOpen() then
    return false
  end
  return NekoData.BehaviorManager.BM_ActivityTasks:HaveFinishedTask(CActivityTasks.ANNIVERSARY_DRAW)
end

function BM_Anniversary:HasFreeGood()
  if not self:IsPackageOpen() then
    return false
  end
  local shopData = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(DataCommon.Anniversary.Other.ShopId) or {}
  local allFreeSoldOut = true
  for _, good in ipairs(shopData) do
    if good.discountPrice == 0 then
      allFreeSoldOut = true
      if good.goodRemain ~= 0 then
        allFreeSoldOut = false
        break
      end
    end
  end
  return not allFreeSoldOut
end

function BM_Anniversary:HasScoreAward()
  if not self:IsPackageOpen() then
    return false
  end
  for _, v in ipairs(self._data.package.award) do
    if v == 1 then
      return true
    end
  end
end

return BM_Anniversary
