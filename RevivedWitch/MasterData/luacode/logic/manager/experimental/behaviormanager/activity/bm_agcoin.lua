-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_agcoin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CoinMissionCfg = (BeanManager.GetTableByName)("mission.ccoinmissionconfig")
local GuidTypes = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local BM_AgCoin = class("BM_AgCoin")
BM_AgCoin.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).agCoinData
end

BM_AgCoin.Clear = function(self)
  -- function num : 0_1
end

BM_AgCoin.IsHighColltionLock = function(self)
  -- function num : 0_2
  do return (self._data).highUnlocked == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_AgCoin.GetUnLockHighItemid = function(self)
  -- function num : 0_3
  return (self._data).highUnlockItemid
end

BM_AgCoin.GetUnLockHighItemNum = function(self)
  -- function num : 0_4
  return (self._data).highUnlockItemNum
end

BM_AgCoin.GetHighAwardInfo = function(self)
  -- function num : 0_5
  return (self._data).highUnlockInfo
end

BM_AgCoin.GetDailyTaskRefreshTime = function(self)
  -- function num : 0_6
  return (self._data).refreshDailyTime
end

BM_AgCoin.GetLimtTimeTasks = function(self)
  -- function num : 0_7
  return (self._data).tasks
end

BM_AgCoin.GetDreamDelegateTasks = function(self)
  -- function num : 0_8
  return (self._data).tasks
end

BM_AgCoin.GetTaskRefreshTime = function(self)
  -- function num : 0_9
  return (self._data).refreshDailyTime
end

BM_AgCoin.GetColltion = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if #(self._data).collection ~= 0 then
    return (self._data).collection
  end
  local BeanCfg = (BeanManager.GetTableByName)("recharge.cseasonpassreward")
  local tempdata = {}
  for i = 1, 8 do
    local d = BeanCfg:GetRecorder(i)
    local data = {}
    data.index = i
    data.coinNum = d.coinNum
    data.common = {state = i % 3, itemId = d.ItemID, itemNum = d.ItemNum}
    data.high = {state = i % 3, itemId = d.PayItemID, itemNum = d.PayItemNum}
    ;
    (table.insert)(tempdata, data)
  end
  return tempdata
end

BM_AgCoin.GetCoinNodeSpacing = function(self)
  -- function num : 0_11
  if #(self._data).collection >= 2 then
    return (((self._data).collection)[2]).coinNum - (((self._data).collection)[1]).coinNum
  end
  return 100
end

BM_AgCoin.IsLastCoinNode = function(self, index)
  -- function num : 0_12
  do return index == #(self._data).collection end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_AgCoin.GetCurrentActId = function(self)
  -- function num : 0_13
  return (self._data).actId
end

BM_AgCoin.IsAgCoinActivityOpen = function(self)
  -- function num : 0_14
  do return (self._data).actId > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_AgCoin.GetBaseInfo = function(self)
  -- function num : 0_15
  local d = {actId = (self._data).actId, endTime = (self._data).endTime, leftTime = (self._data).leftTime, chargeInfo = (self._data).chargeInfo, dreamLevel = (self._data).dreamLevel, highUnlocked = (self._data).highUnlocked, chipInfo = (self._data).chipInfo, taskMaxNum = (self._data).taskMaxNum}
  return d
end

BM_AgCoin.GetRewardTimes = function(self)
  -- function num : 0_16
  return (self._data).canReceiveMaxAward
end

BM_AgCoin.HasUntakeAward = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local has = false
  local num = #(self._data).collection
  for i,v in ipairs((self._data).collection) do
    -- DECOMPILER ERROR at PC21: Unhandled construct in 'MakeBoolean' P1

    if not has and (v.common).state ~= 1 and (v.high).state ~= 1 then
      do
        has = i >= num
        -- DECOMPILER ERROR at PC23: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC23: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  has = has or (self._data).canReceiveMaxAward > 0
  do return has end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

BM_AgCoin.GetDreamCoins = function(self)
  -- function num : 0_18
  return ((self._data).chipInfo).has
end

BM_AgCoin.HasTaskUntakeAward = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local hasAward = false
  for k,v in pairs((self._data).tasks) do
    hasAward = hasAward or v.taskstatus == 3
  end
  do return hasAward end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_AgCoin.ShowRedDot = function(self)
  -- function num : 0_20 , upvalues : _ENV, GuidTypes
  local tag = ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuidTypes.AG_COIN)
  -- DECOMPILER ERROR at PC12: Unhandled construct in 'MakeBoolean' P3

  do return (tag and tag == 0) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_AgCoin.HandleTask = function(self, taskID)
  -- function num : 0_21 , upvalues : CoinMissionCfg, _ENV
  local record = CoinMissionCfg:GetRecorder(taskID)
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
          LogErrorFormat("BM_AgCoin", "Unknown task id " .. tostring(taskID))
        end
      end
    end
  end
end

return BM_AgCoin

