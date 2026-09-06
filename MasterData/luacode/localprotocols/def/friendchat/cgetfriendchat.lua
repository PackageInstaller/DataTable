local CGetFriendChat = dataclass("CGetFriendChat")
CGetFriendChat.ProtocolType = 104
CGetFriendChat.userId = 0
CGetFriendChat.beginId = 0
CGetFriendChat.endId = 0

function CGetFriendChat:Ctor(client)
end

function CGetFriendChat:Marshal(data)
  data.userId = self.userId
  data.beginId = self.beginId
  data.endId = self.endId
end

function CGetFriendChat:Unmarshal(data)
  self.userId = data.userId
  self.beginId = data.beginId
  self.endId = data.endId
  return true
end

function CGetFriendChat:CheckVariable()
  if type(self.userId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.userId) = %s. number required.", type(self.userId))
    return false
  end
  if type(self.beginId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.beginId) = %s. number required.", type(self.beginId))
    return false
  end
  if type(self.endId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.endId) = %s. number required.", type(self.endId))
    return false
  end
  return true
end

return CGetFriendChat
