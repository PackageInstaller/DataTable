local DM_ClientTimer = class("DM_ClientTimer")

function DM_ClientTimer:Ctor()
  self._data = NekoData.Data.clientTimer
  self:Clear()
end

function DM_ClientTimer:Clear()
  if self._timerDic then
    for _, v in pairs(self._timerDic) do
      ServerGameTimer.RemoveTask(v)
    end
  else
    self._timerDic = {}
  end
end

function DM_ClientTimer:OnSCLientTimer(protocol)
  local timerID = protocol.timeId
  local time = protocol.time
  if self._timerDic[timerID] then
    ServerGameTimer.RemoveTask(self._timerDic[timerID])
  end
  self._timerDic[timerID] = ServerGameTimer.AddTask(time // 1000, 0, function()
    local cprotocol = LuaNetManager.CreateProtocol("protocol.activity.cclienttimer")
    if cprotocol then
      cprotocol.timeId = timerID
      cprotocol:Send()
    end
  end, nil)
end

return DM_ClientTimer
