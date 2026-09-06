local DM_BirthDay = class("DM_BirthDay")

function DM_BirthDay:Ctor()
  self._birthday = NekoData.Data.activities.birthday
  self:Clear()
end

function DM_BirthDay:Clear()
  self._birthday.isOpen = false
  self._birthday.startTime = 0
  self._birthday.endTime = 0
  self._birthday.rewardRecord = {}
  self._birthday.shareRecord = 0
  self._birthday.wishRecord = -1
  self._birthday.maxTaskID = -1
  self._birthday.extraItemLeftTime = 0
  self._birthday.extraItemIsLeft = false
  if self._birthday.extraItemLeftTimeTimerID then
    ServerGameTimer.RemoveTask(self._birthday.extraItemLeftTimeTimerID)
    self._birthday.extraItemLeftTimeTimerID = nil
  end
end

function DM_BirthDay:OnSBirthdayActivity(protocol)
  self._birthday.isOpen = protocol.state ~= 0
  self._birthday.startTime = protocol.startDay
  self._birthday.endTime = protocol.endDay
  for key, _ in pairs(self._birthday.rewardRecord) do
    self._birthday.rewardRecord[key] = nil
  end
  for _, value in pairs(protocol.rewardRecord) do
    self._birthday.rewardRecord[value] = true
  end
  self._birthday.shareRecord = protocol.share
  self._birthday.wishRecord = protocol.wish
  self._birthday.maxTaskID = protocol.maxMissionId
  self._birthday.extraItemLeftTime = protocol.extraItemLeftTime
  self._birthday.extraItemIsLeft = true
  if self._birthday.extraItemLeftTimeTimerID then
    ServerGameTimer.RemoveTask(self._birthday.extraItemLeftTimeTimerID)
    self._birthday.extraItemLeftTimeTimerID = nil
  end
  self._birthday.extraItemLeftTimeTimerID = ServerGameTimer.AddTask(protocol.extraItemLeftTime / 1000, -1, function()
    self._birthday.extraItemIsLeft = false
    LuaNotificationCenter.PostNotification(Common.n_OnExtraItemLeftEnd, nil, nil)
  end)
end

function DM_BirthDay:OnSChangeWish(protocol)
  self._birthday.wishRecord = protocol.index
end

function DM_BirthDay:OnSOpenBirthReward(protocol)
  self._birthday.rewardRecord[protocol.rewardId] = true
end

function DM_BirthDay:OnSBirthShare(protocol)
  self._birthday.shareRecord = 1
end

return DM_BirthDay
