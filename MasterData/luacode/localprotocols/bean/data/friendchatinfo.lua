local FriendChatInfo = dataclass("FriendChatInfo")
FriendChatInfo.chatid = 0
FriendChatInfo.sender = 0
FriendChatInfo.msg = ""
FriendChatInfo.time = 0
FriendChatInfo.mark = 0
FriendChatInfo.hyperlinks = ""
FriendChatInfo.bubbleID = 0

function FriendChatInfo:Ctor()
end

function FriendChatInfo:Marshal(data)
  data.chatid = self.chatid
  data.sender = self.sender
  data.msg = self.msg
  data.time = self.time
  data.mark = self.mark
  data.hyperlinks = self.hyperlinks
  data.bubbleID = self.bubbleID
end

function FriendChatInfo:Unmarshal(data)
  self.chatid = data.chatid
  self.sender = data.sender
  self.msg = data.msg
  self.time = data.time
  self.mark = data.mark
  self.hyperlinks = data.hyperlinks
  self.bubbleID = data.bubbleID
end

function FriendChatInfo:CheckVariable()
  if type(self.chatid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.chatid) = %s. number required.", type(self.chatid))
    return false
  end
  if type(self.sender) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.sender) = %s. number required.", type(self.sender))
    return false
  end
  if type(self.msg) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.msg) = %s. string required.", type(self.msg))
    return false
  end
  if type(self.time) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.time) = %s. number required.", type(self.time))
    return false
  end
  if type(self.mark) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.mark) = %s. number required.", type(self.mark))
    return false
  end
  if type(self.hyperlinks) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.hyperlinks) = %s. string required.", type(self.hyperlinks))
    return false
  end
  if type(self.bubbleID) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.bubbleID) = %s. number required.", type(self.bubbleID))
    return false
  end
  return true
end

return FriendChatInfo
