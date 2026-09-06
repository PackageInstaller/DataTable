local DM_GiftOfTime = class("DM_GiftOfTime")

function DM_GiftOfTime:Ctor()
  self._data = NekoData.Data.activities.giftoftime
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
  self._data.weeklyLeftTime = 0
  self._data.chargeInfo = {
    chargeMoneyType = 0,
    levelPrice = 0,
    price = 0
  }
  self._data.canReceiveMaxAward = 0
  self._data.chipInfo = {has = 0, max = -1}
  self._timeElapsed = 0
  self._data.curChallengingId = -1
  self._data.weeklyAwardsList = {}
  self._data.witchLevel = 1
  self._data.bossInfoList = {}
  self._data.battleResult = -1
  LuaNotificationCenter.AddObserver(self, self.Update, Common.n_Update, nil)
end

function DM_GiftOfTime:UpdateLeftTime(info)
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
      LuaNotificationCenter.PostNotification(Common.n_NewDreamSpiralRefresh, nil, "close")
    end
  end
end

function DM_GiftOfTime:UpdateWeekLeftTime(info)
  if self._data.weeklyLeftTime <= 0 then
    return
  end
  local data = info.userInfo
  self._timeElapsed = self._timeElapsed + data.deltaTime
  if self._timeElapsed > 1 then
    self._timeElapsed = self._timeElapsed - 1
    self._data.weeklyLeftTime = self._data.weeklyLeftTime - 1
    if self._data.weeklyLeftTime <= 0 then
      self._data.weeklyLeftTime = 0
      self._data.bossInfoList = {}
      LuaNotificationCenter.PostNotification(Common.n_WeekActRefresh, nil, nil)
    end
  end
end

function DM_GiftOfTime:Update(info)
  self:UpdateLeftTime(info)
  self:UpdateWeekLeftTime(info)
end

function DM_GiftOfTime:Clear()
  NekoData.Data.activities.giftoftime = {}
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
  self._data.weeklyLeftTime = 0
  self._data.chargeInfo = {
    chargeMoneyType = 0,
    levelPrice = 0,
    price = 0
  }
  self._data.chipInfo = {has = 0, max = 1}
  self._data.curChallengingId = -1
  self._data.weeklyAwardsList = {}
  self._data.witchLevel = 1
  self._data.bossInfoList = {}
  self._data.battleResult = -1
end

function DM_GiftOfTime:OnSLittleBattlePass(protocol)
  self._data.actId = protocol.actId
  self._data.leftTime = protocol.leftTime // 1000
  self._data.highUnlocked = protocol.highUnlocked
  self._data.refreshDailyTime = protocol.refreshDailyTime
  for key, _ in pairs(self._data.tasks) do
    self._data.tasks[key] = nil
  end
  for k, v in pairs(protocol.tasks) do
    self._data.tasks[k] = v
  end
  table.sort(self._data.tasks, function(a, b)
    return a.taskid < b.taskid
  end)
  self._data.collection = {}
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
  end
  self._data.endTime = protocol.deadline
  self._data.weeklyLeftTime = protocol.weeklyLeftTime // 1000
  self._data.chargeInfo.chargeMoneyType = protocol.chargeMoneyType
  self._data.chargeInfo.levelPrice = protocol.levelPrice
  self._data.chargeInfo.price = protocol.chargePrice
  self._data.dreamLevel = protocol.level
  self._data.chipInfo = {
    has = protocol.chipNum,
    max = protocol.needChipNum
  }
  self._data.canReceiveMaxAward = protocol.canReceiveMaxAward
  if protocol.actId == 0 or protocol.leftTime // 1000 == 0 then
    self._data.actId = 0
    self._data.leftTime = 0
    LuaNotificationCenter.PostNotification(Common.n_NewDreamSpiralRefresh, nil, "close")
  else
    LuaNotificationCenter.PostNotification(Common.n_NewDreamSpiralRefresh, nil, nil)
  end
end

function DM_GiftOfTime:OnSCoinTasks(protocol)
  for k, v in pairs(protocol.tasks) do
    self._data.tasks[k] = v
  end
  table.sort(self._data.tasks, function(a, b)
    return a.taskid < b.taskid
  end)
end

function DM_GiftOfTime:OnSReturnAgainstBossInfo(protocol)
  self._data.weeklyAwardsList = protocol.againstBossInfo.weeklyAwardsList
  self._data.witchLevel = protocol.againstBossInfo.witchInfo.witchLv
  self._data.bossInfoList = protocol.againstBossInfo.bossInfoList
  self._data.curChallengingId = protocol.bossId
end

function DM_GiftOfTime:OnSendagainstBossBattle(protocol)
  self._data.battleResult = protocol.bossInfo.result
end

function DM_GiftOfTime:OnSwitchinAgainstBossUpLv(protocol)
  self._data.witchLevel = protocol.witchLv
end

return DM_GiftOfTime
