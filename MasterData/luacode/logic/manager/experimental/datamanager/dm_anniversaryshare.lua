local SAnniversaryShareInfoDef = LuaNetManager.GetProtocolDef("protocol.activity.sanniversaryshareinfo")
local DM_AnniversaryShare = class("DM_AnniversaryShare")

function DM_AnniversaryShare:Ctor()
  self._data = NekoData.Data.anniversaryshare
  self:Clear()
end

function DM_AnniversaryShare:Clear()
  self:KillAllTimer()
  self._data.initialTime = 0
  self._data.leftTime = 0
  self._data.shareLeftTime = 0
  self._data.pictureID = 0
  self._data.totalShare = 0
  self._data.totShareAward = {}
  self._data.dailyShareAward = SAnniversaryShareInfoDef.LOCKED
  self._data.totShareAwardCanGet = {}
end

function DM_AnniversaryShare:OnSAnniversaryShareInfo(protocol)
  self:KillAllTimer()
  self._data.initialTime = ServerGameTimer.GetServerTimeForecast()
  self._data.leftTime = protocol.leftTime
  self._data.shareLeftTime = protocol.shareLeftTime
  if protocol.leftTime > 0 then
    self._data.totalTimerId = ServerGameTimer.AddTask(protocol.leftTime / 1000, -1, function()
      self._data.leftTime = 0
      LuaNotificationCenter.PostNotification(Common.n_OnSAnniversaryShareInfo, nil, protocol)
    end)
  end
  if protocol.shareLeftTime > 0 then
    self._data.shareTimerId = ServerGameTimer.AddTask(protocol.shareLeftTime / 1000, -1, function()
      self._data.shareLeftTime = 0
      LuaNotificationCenter.PostNotification(Common.n_OnSAnniversaryShareInfo, nil, protocol)
    end)
  end
  self._data.pictureID = protocol.picture
  self._data.totalShare = protocol.totalShare
  self._data.totShareAward = protocol.totShareAward
  self._data.dailyShareAward = protocol.dailyShareAward
  for key, value in pairs(protocol.totShareAward) do
    if value == SAnniversaryShareInfoDef.UNLOCKED then
      self._data.totShareAwardCanGet[key] = value
    elseif value == SAnniversaryShareInfoDef.FETCHED then
      self._data.totShareAwardCanGet[key] = nil
    end
  end
  if PrintTable then
    PrintTable(protocol, 3, "OnSAnniversaryShareInfo")
  end
end

function DM_AnniversaryShare:KillAllTimer()
  if self._data.totalTimerId then
    ServerGameTimer.RemoveTask(self._data.totalTimerId)
    self._data.totalTimerId = nil
  end
  if self._data.shareTimerId then
    ServerGameTimer.RemoveTask(self._data.shareTimerId)
    self._data.shareTimerId = nil
  end
end

return DM_AnniversaryShare
