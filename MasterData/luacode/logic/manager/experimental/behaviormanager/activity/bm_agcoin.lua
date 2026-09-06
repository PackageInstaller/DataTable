local CoinMissionCfg = BeanManager.GetTableByName("mission.ccoinmissionconfig")
local GuidTypes = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local BM_AgCoin = class("BM_AgCoin")

function BM_AgCoin:Ctor()
  self._data = NekoData.Data.activities.agCoinData
end

function BM_AgCoin:Clear()
end

function BM_AgCoin:IsHighColltionLock()
  return self._data.highUnlocked == 0
end

function BM_AgCoin:GetUnLockHighItemid()
  return self._data.highUnlockItemid
end

function BM_AgCoin:GetUnLockHighItemNum()
  return self._data.highUnlockItemNum
end

function BM_AgCoin:GetHighAwardInfo()
  return self._data.highUnlockInfo
end

function BM_AgCoin:GetDailyTaskRefreshTime()
  return self._data.refreshDailyTime
end

function BM_AgCoin:GetLimtTimeTasks()
  return self._data.tasks
end

function BM_AgCoin:GetDreamDelegateTasks()
  return self._data.tasks
end

function BM_AgCoin:GetTaskRefreshTime()
  return self._data.refreshDailyTime
end

function BM_AgCoin:GetColltion()
  if #self._data.collection ~= 0 then
    return self._data.collection
  end
  local BeanCfg = BeanManager.GetTableByName("recharge.cseasonpassreward")
  local tempdata = {}
  for i = 1, 8 do
    local d = BeanCfg:GetRecorder(i)
    local data = {}
    data.index = i
    data.coinNum = d.coinNum
    data.common = {
      state = i % 3,
      itemId = d.ItemID,
      itemNum = d.ItemNum
    }
    data.high = {
      state = i % 3,
      itemId = d.PayItemID,
      itemNum = d.PayItemNum
    }
    table.insert(tempdata, data)
  end
  return tempdata
end

function BM_AgCoin:GetCoinNodeSpacing()
  if #self._data.collection >= 2 then
    return self._data.collection[2].coinNum - self._data.collection[1].coinNum
  end
  return 100
end

function BM_AgCoin:IsLastCoinNode(index)
  return index == #self._data.collection
end

function BM_AgCoin:GetCurrentActId()
  return self._data.actId
end

function BM_AgCoin:IsAgCoinActivityOpen()
  return self._data.actId > 0
end

function BM_AgCoin:GetBaseInfo()
  local d = {
    actId = self._data.actId,
    endTime = self._data.endTime,
    leftTime = self._data.leftTime,
    chargeInfo = self._data.chargeInfo,
    dreamLevel = self._data.dreamLevel,
    highUnlocked = self._data.highUnlocked,
    chipInfo = self._data.chipInfo,
    taskMaxNum = self._data.taskMaxNum
  }
  return d
end

function BM_AgCoin:GetRewardTimes()
  return self._data.canReceiveMaxAward
end

function BM_AgCoin:HasUntakeAward()
  local has = false
  local num = #self._data.collection
  for i, v in ipairs(self._data.collection) do
    if i < num then
      has = has or v.common.state == 1 or v.high.state == 1
    end
  end
  has = has or self._data.canReceiveMaxAward > 0
  return has
end

function BM_AgCoin:GetDreamCoins()
  return self._data.chipInfo.has
end

function BM_AgCoin:HasTaskUntakeAward()
  local hasAward = false
  for k, v in pairs(self._data.tasks) do
    hasAward = hasAward or v.taskstatus == 3
  end
  return hasAward
end

function BM_AgCoin:ShowRedDot()
  local tag = NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuidTypes.AG_COIN)
  return tag and tag == 0 or self:HasUntakeAward()
end

function BM_AgCoin:HandleTask(taskID)
  local record = CoinMissionCfg:GetRecorder(taskID)
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
    LogErrorFormat("BM_AgCoin", "Unknown task id " .. tostring(taskID))
  end
end

return BM_AgCoin
