-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_giftoftime.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CBpDailyTaskConfig = (BeanManager.GetTableByName)("mission.cbpdailytaskconfig")
local CbpBossHitBoss = (BeanManager.GetTableByName)("activity.cbpbosshitboss")
local CbpBossHitRole = (BeanManager.GetTableByName)("activity.cbpbosshitrole")
local CLittleBattlePassReward = (BeanManager.GetTableByName)("activity.clittlebattlepassreward")
local GuidTypes = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local limmitMaxNum = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(120)).Value)
local BM_GiftOfTime = class("BM_GiftOfTime")
BM_GiftOfTime.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).giftoftime
end

BM_GiftOfTime.GetIsOpen = function(self)
  -- function num : 0_1
  do return (self._data).actId > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_GiftOfTime.HasFreeGood = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self._puzzleBM = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
  self._mazeBM = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeMazeActivityManagerID)
  if not self:IsBossKillOpen() and (not self._puzzleBM or not (self._puzzleBM):GetIsOpen()) and (not self._mazeBM or not (self._mazeBM):GetIsOpen()) then
    return 
  end
  if not ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID(((DataCommon.GiftofTime).Shop).ShopID) then
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

BM_GiftOfTime.ShowRedDot = function(self)
  -- function num : 0_3
  if self:GetIsOpen() and not self:HasUntakeAward() and not self:HasBossKillRedDot() then
    return self:HasFreeGood()
  end
end

BM_GiftOfTime.IsHighColltionLock = function(self)
  -- function num : 0_4
  do return (self._data).highUnlocked == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_GiftOfTime.GetUnLockHighItemid = function(self)
  -- function num : 0_5
  return (self._data).highUnlockItemid
end

BM_GiftOfTime.GetUnLockHighItemNum = function(self)
  -- function num : 0_6
  return (self._data).highUnlockItemNum
end

BM_GiftOfTime.GetHighAwardInfo = function(self)
  -- function num : 0_7
  return (self._data).highUnlockInfo
end

BM_GiftOfTime.GetDailyTaskRefreshTime = function(self)
  -- function num : 0_8
  return (self._data).refreshDailyTime
end

BM_GiftOfTime.GetDreamDelegateTasks = function(self)
  -- function num : 0_9
  return (self._data).tasks
end

BM_GiftOfTime.GetTaskRefreshTime = function(self)
  -- function num : 0_10
  return (self._data).refreshDailyTime
end

BM_GiftOfTime.GetColltion = function(self)
  -- function num : 0_11 , upvalues : _ENV, CLittleBattlePassReward, limmitMaxNum
  if not self._curActRecorder then
    self._curActRecorder = {}
    for i,v in ipairs(CLittleBattlePassReward:GetAllIds()) do
      local recoder = CLittleBattlePassReward:GetRecorder(v)
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

      if recoder.ShopType == (self._data).actId then
        (self._curActRecorder)[recoder.level] = recoder
      end
    end
  end
  do
    if #(self._data).collection ~= 0 then
      local maxColltionNum = #(self._data).collection
      if (self._data).dreamLevel >= 25 then
        local gap = (self._data).dreamLevel - 24
        local t = (math.ceil)(gap / 3)
        maxColltionNum = 3 * t + 30
      end
      do
        maxColltionNum = (math.min)(limmitMaxNum, maxColltionNum)
        do
          local tempdata = {}
          for i = 1, maxColltionNum do
            local data = {}
            if i <= #(self._data).collection then
              data = ((self._data).collection)[i]
            else
              local index = i
              if i > 30 then
                index = i % 3
                if index == 1 then
                  index = -1
                else
                  if index == 2 then
                    index = -2
                  else
                    if index == 0 then
                      index = -3
                    end
                  end
                end
              end
              local d = (self._curActRecorder)[index]
              data.level = i
              data.index = i
              data.coinNum = d.coinNum
              data.common = {state = 0, itemId = d.ItemID, itemNum = d.ItemNum}
              data.high = {state = 0, itemId = d.PayItemID, itemNum = d.PayItemNum}
            end
            do
              do
                ;
                (table.insert)(tempdata, data)
                -- DECOMPILER ERROR at PC107: LeaveBlock: unexpected jumping out DO_STMT

              end
            end
          end
          do return tempdata end
          return {}
        end
      end
    end
  end
end

BM_GiftOfTime.GetCurrentActId = function(self)
  -- function num : 0_12
  return (self._data).actId
end

BM_GiftOfTime.GetBaseInfo = function(self)
  -- function num : 0_13
  local d = {actId = (self._data).actId, endTime = (self._data).endTime, leftTime = (self._data).leftTime, chargeInfo = (self._data).chargeInfo, dreamLevel = (self._data).dreamLevel, highUnlocked = (self._data).highUnlocked, chipInfo = (self._data).chipInfo}
  return d
end

BM_GiftOfTime.HasUntakeAward = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local has = false
  local num = #(self._data).collection
  for i,v in ipairs((self._data).collection) do
    has = has or (v.common).state == 1 or (v.high).state == 1
  end
  do return has end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_GiftOfTime.GetDreamCoins = function(self)
  -- function num : 0_15
  return ((self._data).chipInfo).has
end

BM_GiftOfTime.GetWeeklyLeftTime = function(self)
  -- function num : 0_16
  return (self._data).weeklyLeftTime
end

BM_GiftOfTime.IsBossKillOpen = function(self)
  -- function num : 0_17
  do return (self._data).weeklyLeftTime > 0 and #(self._data).bossInfoList > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_GiftOfTime.HasTasksAward = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local hasAward = false
  for k,v in pairs((self._data).tasks) do
    hasAward = hasAward or v.taskstatus == 3
  end
  do return hasAward end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_GiftOfTime.HasWeekAward = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local hasAward = false
  for k,v in pairs((self._data).weeklyAwardsList) do
    hasAward = hasAward or v.awardStatus == 1
  end
  do return hasAward end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_GiftOfTime.HasBossKillRedDot = function(self)
  -- function num : 0_20
  if self:IsBossKillOpen() and not self:CanWitchLevelUp() and not self:HasTasksAward() then
    do return self:HasWeekAward() end
  end
end

BM_GiftOfTime.CanWitchLevelUp = function(self)
  -- function num : 0_21 , upvalues : _ENV, CbpBossHitRole
  local charlevelupneeditemcurrentnum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.KillBossCoin)
  local charlevelupitemneednum = 0
  if #CbpBossHitRole:GetAllIds() - 1 < (self._data).witchLevel then
    charlevelupitemneednum = 0
  else
    charlevelupitemneednum = (CbpBossHitRole:GetRecorder((self._data).witchLevel + 1)).num
  end
  if charlevelupitemneednum <= charlevelupneeditemcurrentnum and charlevelupitemneednum > 0 then
    return true
  else
    return false
  end
end

BM_GiftOfTime.GetRoleList = function(self)
  -- function num : 0_22 , upvalues : CbpBossHitRole, _ENV
  local result = {}
  local cfg = CbpBossHitRole:GetRecorder((self._data).witchLevel)
  if cfg then
    (table.insert)(result, {roleId = 1, roleLv = (self._data).witchLevel, attack = cfg.basicAttack, blood = cfg.basicHealth, cfg = cfg})
  end
  return result
end

BM_GiftOfTime.GetMonsterList = function(self)
  -- function num : 0_23 , upvalues : _ENV, CbpBossHitBoss
  local result = {}
  for i,v in ipairs((self._data).bossInfoList) do
    local cfg = CbpBossHitBoss:GetRecorder(v.bossID)
    if cfg then
      (table.insert)(result, {id = cfg.id, lv = cfg.enemyLevel, name = (TextManager.GetText)(cfg.nameID), handbookid = cfg.handbookID, enemyHP = cfg.enemyHP, enemyATK = cfg.enemyATK, itemID = cfg.itemID, itemNum = cfg.itemNum, scale = cfg.scale, position = cfg.position, result = v.result})
    else
      LogErrorFormat("BM_GiftOfTime", "Sever BossID :%s is No Exist Clent Table(CbpBossHitBoss)", v.bossID)
    end
  end
  ;
  (table.sort)(result, function(v1, v2)
    -- function num : 0_23_0
    do return v1.id < v2.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return result
end

BM_GiftOfTime.GetCurChallengingId = function(self)
  -- function num : 0_24
  return (self._data).curChallengingId
end

BM_GiftOfTime.GetAwardList = function(self)
  -- function num : 0_25
  return (self._data).weeklyAwardsList
end

BM_GiftOfTime.GetBossTime = function(self)
  -- function num : 0_26 , upvalues : _ENV
  local result = 0
  for i,v in ipairs((self._data).bossInfoList) do
    if v.result == 1 then
      result = result + 1
    end
  end
  return result
end

BM_GiftOfTime.GetLastBattleResult = function(self)
  -- function num : 0_27
  return (self._data).battleResult
end

BM_GiftOfTime.HandleTask = function(self, taskID)
  -- function num : 0_28 , upvalues : CBpDailyTaskConfig, _ENV
  local record = CBpDailyTaskConfig:GetRecorder(taskID)
  if record then
    local type = record.jumptype
    if type > 0 then
      local handler = require("logic.task.taskhandlers." .. type)
      if handler then
        handler:Handle(record)
      end
    else
      do
        do
          if type == -1 then
            ((DialogManager.CreateSingletonDialog)("chat.guidecommentdialog")):SetData(3)
          end
          LogErrorFormat("BM_GiftOfTime", "Unknown task id " .. tostring(taskID))
        end
      end
    end
  end
end

return BM_GiftOfTime

