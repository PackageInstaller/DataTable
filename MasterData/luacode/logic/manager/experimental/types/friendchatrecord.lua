local FriendChatRecord = strictclass("FriendChatRecord")

function FriendChatRecord:Ctor()
  self._bMyMsg = nil
  self._chatTime = nil
  self._chatmsg = nil
  self._hyperlinks = nil
  self._bubbleID = nil
end

function FriendChatRecord:SetData(bean, bFromMy)
  self._bMyMsg = bFromMy
  self._chatTime = bean.time
  self._chatmsg = bean.msg
  self._hyperlinks = {}
  if type(bean.hyperlinks) == "table" then
    self._hyperlinks = bean.hyperlinks
  elseif bean.hyperlinks ~= "" then
    self._hyperlinks = {}
    self._hyperlinks[1] = {}
    self._hyperlinks[1] = JSON.decode(bean.hyperlinks)
  end
  self._bubbleID = bean.bubbleID
end

function FriendChatRecord:IsMySendMsg()
  if not self._bMyMsg then
    return false
  end
  return true
end

function FriendChatRecord:GetChatMsg()
  return self._chatmsg
end

function FriendChatRecord:GetChatTimeStr()
  return ServerGameTimer.GetDetailTimeStr(self._chatTime)
end

function FriendChatRecord:GetChatTime()
  return self._chatTime
end

return FriendChatRecord
