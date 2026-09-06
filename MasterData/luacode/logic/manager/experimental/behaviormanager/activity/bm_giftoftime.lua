local CBpDailyTaskConfig = BeanManager.GetTableByName("mission.cbpdailytaskconfig")
local CbpBossHitBoss = BeanManager.GetTableByName("activity.cbpbosshitboss")
local CbpBossHitRole = BeanManager.GetTableByName("activity.cbpbosshitrole")
local CLittleBattlePassReward = BeanManager.GetTableByName("activity.clittlebattlepassreward")
local GuidTypes = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local limmitMaxNum = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(120).Value)
local BM_GiftOfTime = class("BM_GiftOfTime")

function BM_GiftOfTime:Ctor()
  self._data = NekoData.Data.activities.giftoftime
end

function BM_GiftOfTime:GetIsOpen()
  return self._data.actId > 0
end

function BM_GiftOfTime:HasFreeGood()
  self._puzzleBM = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
  self._mazeBM = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeMazeActivityManagerID)
  if not self:IsBossKillOpen() and (not self._puzzleBM or not self._puzzleBM:GetIsOpen()) and (not self._mazeBM or not self._mazeBM:GetIsOpen()) then
    return
  end
  local shopData = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(DataCommon.GiftofTime.Shop.ShopID) or {}
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

function BM_GiftOfTime:ShowRedDot()
  return not self:GetIsOpen() or self:HasUntakeAward() or self:HasBossKillRedDot() or self:HasFreeGood()
end

function BM_GiftOfTime:IsHighColltionLock()
  return self._data.highUnlocked == 0
end

function BM_GiftOfTime:GetUnLockHighItemid()
  return self._data.highUnlockItemid
end

function BM_GiftOfTime:GetUnLockHighItemNum()
  return self._data.highUnlockItemNum
end

function BM_GiftOfTime:GetHighAwardInfo()
  return self._data.highUnlockInfo
end

function BM_GiftOfTime:GetDailyTaskRefreshTime()
  return self._data.refreshDailyTime
end

function BM_GiftOfTime:GetDreamDelegateTasks()
  return self._data.tasks
end

function BM_GiftOfTime:GetTaskRefreshTime()
  return self._data.refreshDailyTime
end

function BM_GiftOfTime:GetColltion()
  if not self._curActRecorder then
    self._curActRecorder = {}
    for i, v in ipairs(CLittleBattlePassReward:GetAllIds()) do
      local recoder = CLittleBattlePassReward:GetRecorder(v)
      if recoder.ShopType == self._data.actId then
        self._curActRecorder[recoder.level] = recoder
      end
    end
  end
  if #self._data.collection ~= 0 then
    local maxColltionNum = #self._data.collection
    if self._data.dreamLevel >= 25 then
      local gap = self._data.dreamLevel - 24
      local t = math.ceil(gap / 3)
      maxColltionNum = 3 * t + 30
    end
    maxColltionNum = math.min(limmitMaxNum, maxColltionNum)
    local tempdata = {}
    for i = 1, maxColltionNum do
      local data = {}
      if i <= #self._data.collection then
        data = self._data.collection[i]
      else
        local index = i
        if 30 < i then
          index = i % 3
          if index == 1 then
            index = -1
          elseif index == 2 then
            index = -2
          elseif index == 0 then
            index = -3
          end
        end
        local d = self._curActRecorder[index]
        data.level = i
        data.index = i
        data.coinNum = d.coinNum
        data.common = {
          state = 0,
          itemId = d.ItemID,
          itemNum = d.ItemNum
        }
        data.high = {
          state = 0,
          itemId = d.PayItemID,
          itemNum = d.PayItemNum
        }
      end
      table.insert(tempdata, data)
    end
    return tempdata
  end
  return {}
end

function BM_GiftOfTime:GetCurrentActId()
  return self._data.actId
end

function BM_GiftOfTime:GetBaseInfo()
  local d = {
    actId = self._data.actId,
    endTime = self._data.endTime,
    leftTime = self._data.leftTime,
    chargeInfo = self._data.chargeInfo,
    dreamLevel = self._data.dreamLevel,
    highUnlocked = self._data.highUnlocked,
    chipInfo = self._data.chipInfo
  }
  return d
end

function BM_GiftOfTime:HasUntakeAward()
  local has = false
  local num = #self._data.collection
  for i, v in ipairs(self._data.collection) do
    has = has or v.common.state == 1 or v.high.state == 1
  end
  return has
end

function BM_GiftOfTime:GetDreamCoins()
  return self._data.chipInfo.has
end

function BM_GiftOfTime:GetWeeklyLeftTime()
  return self._data.weeklyLeftTime
end

function BM_GiftOfTime:IsBossKillOpen()
  return self._data.weeklyLeftTime > 0 and 0 < #self._data.bossInfoList
end

function BM_GiftOfTime:HasTasksAward()
  local hasAward = false
  for k, v in pairs(self._data.tasks) do
    hasAward = hasAward or v.taskstatus == 3
  end
  return hasAward
end

function BM_GiftOfTime:HasWeekAward()
  local hasAward = false
  for k, v in pairs(self._data.weeklyAwardsList) do
    hasAward = hasAward or v.awardStatus == 1
  end
  return hasAward
end

function BM_GiftOfTime:HasBossKillRedDot()
  if self:IsBossKillOpen() then
    return self:CanWitchLevelUp() or self:HasTasksAward() or self:HasWeekAward()
  end
end

function BM_GiftOfTime:CanWitchLevelUp()
  local charlevelupneeditemcurrentnum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.KillBossCoin)
  local charlevelupitemneednum = 0
  if self._data.witchLevel > #CbpBossHitRole:GetAllIds() - 1 then
    charlevelupitemneednum = 0
  else
    charlevelupitemneednum = CbpBossHitRole:GetRecorder(self._data.witchLevel + 1).num
  end
  if charlevelupneeditemcurrentnum >= charlevelupitemneednum and 0 < charlevelupitemneednum then
    return true
  else
    return false
  end
end

function BM_GiftOfTime:GetRoleList()
  local result = {}
  local cfg = CbpBossHitRole:GetRecorder(self._data.witchLevel)
  if cfg then
    table.insert(result, {
      roleId = 1,
      roleLv = self._data.witchLevel,
      attack = cfg.basicAttack,
      blood = cfg.basicHealth,
      cfg = cfg
    })
  end
  return result
end

function BM_GiftOfTime:GetMonsterList()
  local result = {}
  for i, v in ipairs(self._data.bossInfoList) do
    local cfg = CbpBossHitBoss:GetRecorder(v.bossID)
    if cfg then
      table.insert(result, {
        id = cfg.id,
        lv = cfg.enemyLevel,
        name = TextManager.GetText(cfg.nameID),
        handbookid = cfg.handbookID,
        enemyHP = cfg.enemyHP,
        enemyATK = cfg.enemyATK,
        itemID = cfg.itemID,
        itemNum = cfg.itemNum,
        scale = cfg.scale,
        position = cfg.position,
        result = v.result
      })
    else
      LogErrorFormat("BM_GiftOfTime", "Sever BossID :%s is No Exist Clent Table(CbpBossHitBoss)", v.bossID)
    end
  end
  table.sort(result, function(v1, v2)
    return v1.id < v2.id
  end)
  return result
end

function BM_GiftOfTime:GetCurChallengingId()
  return self._data.curChallengingId
end

function BM_GiftOfTime:GetAwardList()
  return self._data.weeklyAwardsList
end

function BM_GiftOfTime:GetBossTime()
  local result = 0
  for i, v in ipairs(self._data.bossInfoList) do
    if v.result == 1 then
      result = result + 1
    end
  end
  return result
end

function BM_GiftOfTime:GetLastBattleResult()
  return self._data.battleResult
end

function BM_GiftOfTime:HandleTask(taskID)
  local record = CBpDailyTaskConfig:GetRecorder(taskID)
  if record then
    local type = record.jumptype
    if 0 < type then
      local handler = require("logic.task.taskhandlers." .. type)
      if handler then
        handler:Handle(record)
      end
    elseif type == -1 then
      DialogManager.CreateSingletonDialog("chat.guidecommentdialog"):SetData(3)
    end
  else
    LogErrorFormat("BM_GiftOfTime", "Unknown task id " .. tostring(taskID))
  end
end

return BM_GiftOfTime
