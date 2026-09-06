local DM_SevenGrow = class("DM_SevenGrow")

function DM_SevenGrow:Ctor()
  self._sevengrow = NekoData.Data.sevengrow
  self._sevengrow.sevenDaysIsOpen = false
end

function DM_SevenGrow:Clear()
  self._sevengrow.sevenDaysIsOpen = false
  self._sevengrow.ramainTime = nil
  self._sevengrow.initialRemainTime = nil
  self._sevengrow.startTime = nil
  self._sevengrow.gameTimerId = nil
  self._sevengrow.version = -1
end

function DM_SevenGrow:OnSSevenDaysOpen(protocol)
  self:RemoveTask()
  self._sevengrow.initialRemainTime = protocol.remainTime
  self._sevengrow.startTime = ServerGameTimer.GetServerTimeForecast()
  self._sevengrow.gameTimerId = ServerGameTimer.AddTask(protocol.remainTime / 1000, -1, function()
    self._sevengrow.sevenDaysIsOpen = false
  end)
  self._sevengrow.sevenDaysIsOpen = true
  self._sevengrow.version = protocol.version
end

function DM_SevenGrow:RemoveTask()
  if self._sevengrow.gameTimerId ~= nil then
    ServerGameTimer.RemoveTask(self._sevengrow.gameTimerId)
  end
end

return DM_SevenGrow
