local DM_Message = class("DM_Message")

function DM_Message:Ctor()
  self._message = NekoData.Data.message
  self._message.topNoticeBar = {}
  self._message.functionUnlock = {}
end

function DM_Message:Clear()
  while self._message.topNoticeBar[#self._message.topNoticeBar] do
    table.remove(self._message.topNoticeBar, #self._message.topNoticeBar)
  end
  while self._message.functionUnlock[#self._message.functionUnlock] do
    table.remove(self._message.functionUnlock, #self._message.functionUnlock)
  end
end

return DM_Message
