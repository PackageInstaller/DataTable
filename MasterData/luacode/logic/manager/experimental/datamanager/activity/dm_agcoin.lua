local DM_AgCoin = class("DM_AgCoin")

function DM_AgCoin:Ctor()
  self._data = NekoData.Data.activities.agCoinData
  self._data.highUnlocked = 0
  self._data.refreshDailyTime = 0
  self._data.collection = {}
  self._data.tasks = {}
  self._data.actId = 0
  self._data.endTime = 0
  self._data.chargeId = 0
  self._data.dreamLevel = 0
  self._data.dreamChipNum = 0
  self._data.leftTime = 0
  self._data.chargeInfo = {
    chargeMoneyType = 0,
    levelPrice = 0,
    price = 0
  }
  self._data.canReceiveMaxAward = 0
  self._data.taskMaxNum = 0
  self._data.chipInfo = {has = 0, max = -1}
  self._timeElapsed = 0
  LuaNotificationCenter.AddObserver(self, self.Update, Common.n_Update, nil)
end

function DM_AgCoin:Update(info)
  if self._data.leftTime <= 0 then
    return
  end
  local data = info.userInfo
  self._timeElapsed = self._timeElapsed + data.deltaTime
  if self._timeElapsed > 1 then
    self._timeElapsed = self._timeElapsed - 1
    self._data.leftTime = self._data.leftTime - 1
    if self._data.leftTime <= 0 then
      self._data.actId = 0
      self._data.leftTime = 0
      LuaNotificationCenter.PostNotification(Common.n_DreamSpiralRefresh, nil, "close")
    end
  end
end

function DM_AgCoin:Clear()
  NekoData.Data.activities.agCoinData = {}
  self._data.highUnlocked = 0
  self._data.collection = {}
  self._data.tasks = {}
  self._data.actId = 0
  self._data.endTime = 0
  self._data.chargeId = 0
  self._data.dreamLevel = 0
  self._data.dreamChipNum = 0
  self._data.leftTime = 0
  self._data.canReceiveMaxAward = 0
  self._data.taskMaxNum = 0
  self._data.chargeInfo = {
    chargeMoneyType = 0,
    levelPrice = 0,
    price = 0
  }
  self._data.chipInfo = {has = 0, max = 1}
end

function DM_AgCoin:OnSAgCoinInfo(protocol)
  self._data.actId = protocol.actId
  self._data.leftTime = protocol.leftTime // 1000
  self._data.highUnlocked = protocol.highUnlocked
  self._data.refreshDailyTime = protocol.refreshDailyTime
  local hasAward = false
  for k, v in pairs(protocol.tasks) do
    self._data.tasks[k] = v
    hasAward = hasAward or v.taskstatus == 3
  end
  NekoData.DataManager.DM_Task:SetIndexRedValue(7, hasAward)
  self._data.collection = {}
  hasAward = false
  local num = #protocol.commonCollection
  for i = 1, num do
    local data = {}
    data.index = i
    data.level = protocol.commonCollection[i].level
    local common = protocol.commonCollection[i]
    data.common = {
      state = common.state,
      itemId = common.itemId,
      itemNum = common.itemNum
    }
    local high = protocol.highCollection[i]
    data.high = {
      state = high.state,
      itemId = high.itemId,
      itemNum = high.itemNum
    }
    table.insert(self._data.collection, data)
    if i < num then
      hasAward = hasAward or common.state == 1 or high.state == 1
    end
  end
  self._data.endTime = protocol.deadline
  self._data.chargeInfo.chargeMoneyType = protocol.chargeMoneyType
  self._data.chargeInfo.levelPrice = protocol.levelPrice
  self._data.chargeInfo.price = protocol.chargePrice
  self._data.dreamLevel = protocol.level
  self._data.chipInfo = {
    has = protocol.chipNum,
    max = protocol.needChipNum
  }
  self._data.canReceiveMaxAward = protocol.canReceiveMaxAward
  self._data.taskMaxNum = protocol.maxTaskNum or 0
  if protocol.actId == 0 or protocol.leftTime // 1000 == 0 then
    self._data.actId = 0
    self._data.leftTime = 0
    LuaNotificationCenter.PostNotification(Common.n_DreamSpiralRefresh, nil, "close")
  else
    LuaNotificationCenter.PostNotification(Common.n_DreamSpiralRefresh, nil, nil)
  end
end

function DM_AgCoin:OnSCoinTasks(protocol)
  local hasAward = false
  for k, v in pairs(protocol.tasks) do
    self._data.tasks[k] = v
    hasAward = hasAward or v.taskstatus == 3
  end
  NekoData.DataManager.DM_Task:SetIndexRedValue(7, hasAward)
end

return DM_AgCoin
